-- Persist per-user subscription state from Superwall webhooks so support
-- lookups ("is user X subscribed?") resolve via SQL instead of the dashboard.
-- See docs/serene-wandering-cook plan / Phase 2.

-- Core subscription state, one row per app_user_id.
CREATE TABLE IF NOT EXISTS public.user_subscriptions (
    app_user_id TEXT PRIMARY KEY,
    status TEXT NOT NULL,                      -- active | expired | cancelled | refunded | in_billing_grace | paused
    product_id TEXT,
    original_transaction_id TEXT,
    transaction_id TEXT,
    store TEXT,                                -- APP_STORE | PLAY_STORE | STRIPE
    environment TEXT,                          -- PRODUCTION | SANDBOX
    started_at TIMESTAMPTZ,
    renewed_at TIMESTAMPTZ,
    expires_at TIMESTAMPTZ,
    cancelled_at TIMESTAMPTZ,
    refunded_at TIMESTAMPTZ,
    last_event_type TEXT,
    raw_event JSONB,
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_user_subs_status ON public.user_subscriptions(status);
CREATE INDEX IF NOT EXISTS idx_user_subs_expires ON public.user_subscriptions(expires_at);

-- Append-only log of every webhook delivery. UNIQUE(event_id) drops retries.
CREATE TABLE IF NOT EXISTS public.user_subscription_events (
    id BIGSERIAL PRIMARY KEY,
    app_user_id TEXT NOT NULL,
    event_type TEXT NOT NULL,
    event_id TEXT,
    transaction_id TEXT,
    payload JSONB NOT NULL,
    received_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(event_id)
);
CREATE INDEX IF NOT EXISTS idx_user_sub_events_user ON public.user_subscription_events(app_user_id);

-- Bridge column: a user's Supabase id paired with the device UUID they were
-- using pre-sign-in. Lets us resolve purchases made under the device UUID
-- (before identify() re-tagged them) to the eventual Supabase account.
ALTER TABLE public.user_profiles ADD COLUMN IF NOT EXISTS device_user_id TEXT;
CREATE INDEX IF NOT EXISTS idx_user_profiles_device_user_id ON public.user_profiles(device_user_id);

-- RLS
ALTER TABLE public.user_subscriptions ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "users read own sub" ON public.user_subscriptions;
CREATE POLICY "users read own sub" ON public.user_subscriptions
    FOR SELECT USING (
        app_user_id = auth.uid()::text
        OR app_user_id IN (
            SELECT device_user_id FROM public.user_profiles WHERE id = auth.uid()
        )
    );

ALTER TABLE public.user_subscription_events ENABLE ROW LEVEL SECURITY;
-- No SELECT policy: user_subscription_events is service_role only.

-- Support helper: given a Supabase user id, return the current subscription row
-- whether it's keyed by that uuid or by the user's device_user_id bridge.
CREATE OR REPLACE FUNCTION public.current_subscription(user_id UUID)
RETURNS TABLE(status TEXT, product_id TEXT, expires_at TIMESTAMPTZ)
LANGUAGE SQL STABLE AS $$
    SELECT s.status, s.product_id, s.expires_at
    FROM public.user_subscriptions s
    WHERE s.app_user_id = user_id::text
       OR s.app_user_id IN (
           SELECT p.device_user_id
           FROM public.user_profiles p
           WHERE p.id = user_id AND p.device_user_id IS NOT NULL
       )
    ORDER BY s.updated_at DESC
    LIMIT 1;
$$;
