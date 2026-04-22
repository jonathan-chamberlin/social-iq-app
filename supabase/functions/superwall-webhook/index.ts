// Superwall subscription webhook → Supabase.
//
// Verifies Superwall/Svix signature, appends every delivery to
// user_subscription_events (UNIQUE(event_id) drops retries), and upserts the
// canonical user_subscriptions row so support can answer "is user X subscribed?"
// with one SQL query.

import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "npm:@supabase/supabase-js@2";
import { Webhook } from "npm:svix@1";

const SUPERWALL_WEBHOOK_SECRET = Deno.env.get("SUPERWALL_WEBHOOK_SECRET");
const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;

const SUPERWALL_ALIAS_PREFIX = "$SuperwallAlias:";

type SupabaseSub = {
    app_user_id: string;
    status: string;
    product_id: string | null;
    original_transaction_id: string | null;
    transaction_id: string | null;
    store: string | null;
    environment: string | null;
    started_at: string | null;
    renewed_at: string | null;
    expires_at: string | null;
    cancelled_at: string | null;
    refunded_at: string | null;
    last_event_type: string;
    raw_event: unknown;
    updated_at: string;
};

type EventMapping = {
    status: string;
    timestampColumn: "started_at" | "renewed_at" | "cancelled_at" | "refunded_at" | null;
};

function mapEvent(type: string, price: number | undefined): EventMapping {
    // A refund is signaled by price < 0 on any event type.
    if (typeof price === "number" && price < 0) {
        return { status: "refunded", timestampColumn: "refunded_at" };
    }
    switch (type) {
        case "initial_purchase":
            return { status: "active", timestampColumn: "started_at" };
        case "renewal":
        case "uncancellation":
            return { status: "active", timestampColumn: "renewed_at" };
        case "cancellation":
            // Apple subscriptions stay entitled through the paid period after
            // the user cancels auto-renew. `expiration` flips status to expired.
            return { status: "active", timestampColumn: "cancelled_at" };
        case "expiration":
            return { status: "expired", timestampColumn: null };
        case "refund":
            return { status: "refunded", timestampColumn: "refunded_at" };
        case "billing_issue":
            return { status: "in_billing_grace", timestampColumn: null };
        case "subscription_paused":
        case "pause":
            return { status: "paused", timestampColumn: null };
        default:
            return { status: "active", timestampColumn: null };
    }
}

function stripAliasPrefix(id: string): string {
    return id.startsWith(SUPERWALL_ALIAS_PREFIX)
        ? id.slice(SUPERWALL_ALIAS_PREFIX.length)
        : id;
}

function toIsoOrNull(ms: unknown): string | null {
    if (typeof ms !== "number" || !Number.isFinite(ms)) return null;
    return new Date(ms).toISOString();
}

Deno.serve(async (req: Request) => {
    if (req.method !== "POST") {
        return new Response("Method not allowed", { status: 405 });
    }
    if (!SUPERWALL_WEBHOOK_SECRET) {
        console.error("SUPERWALL_WEBHOOK_SECRET is not configured");
        return new Response("Server misconfigured", { status: 500 });
    }

    const rawBody = await req.text();
    const headers = {
        "svix-id": req.headers.get("svix-id") ?? "",
        "svix-timestamp": req.headers.get("svix-timestamp") ?? "",
        "svix-signature": req.headers.get("svix-signature") ?? "",
    };

    let event: Record<string, unknown>;
    try {
        const wh = new Webhook(SUPERWALL_WEBHOOK_SECRET);
        event = wh.verify(rawBody, headers) as Record<string, unknown>;
    } catch (err) {
        console.error("Signature verification failed", err);
        return new Response("Invalid signature", { status: 400 });
    }

    const type = String(event.type ?? "");
    const data = (event.data ?? {}) as Record<string, unknown>;
    const originalAppUserIdRaw = String(data.originalAppUserId ?? "");
    if (!originalAppUserIdRaw) {
        console.error("Missing originalAppUserId in payload", event);
        return new Response("Malformed payload", { status: 400 });
    }

    const appUserId = stripAliasPrefix(originalAppUserIdRaw);
    const price = typeof data.price === "number" ? (data.price as number) : undefined;
    const mapping = mapEvent(type, price);

    const supabase = createClient(SUPABASE_URL, SERVICE_ROLE_KEY, {
        auth: { persistSession: false, autoRefreshToken: false },
    });

    // 1. Append to the event log. UNIQUE(event_id) makes duplicate deliveries a
    //    no-op instead of an error.
    const eventId = (data.id as string | undefined) ?? null;
    const insertRes = await supabase
        .from("user_subscription_events")
        .insert({
            app_user_id: appUserId,
            event_type: type,
            event_id: eventId,
            transaction_id: (data.transactionId as string | undefined) ?? null,
            payload: event,
        });
    if (insertRes.error && insertRes.error.code !== "23505") {
        // 23505 = unique_violation (duplicate delivery) — expected and fine.
        console.error("event log insert failed", insertRes.error);
        return new Response("DB error", { status: 500 });
    }
    if (insertRes.error?.code === "23505") {
        // Duplicate delivery: the prior call already upserted subscription state.
        // Returning 200 so Svix stops retrying.
        return new Response("ok (duplicate)", { status: 200 });
    }

    // 2. Upsert canonical subscription row.
    const nowIso = new Date().toISOString();
    const row: Partial<SupabaseSub> = {
        app_user_id: appUserId,
        status: mapping.status,
        product_id: (data.productId as string | undefined) ?? null,
        original_transaction_id:
            (data.originalTransactionId as string | undefined) ?? null,
        transaction_id: (data.transactionId as string | undefined) ?? null,
        store: (data.store as string | undefined) ?? null,
        environment: (data.environment as string | undefined) ?? null,
        expires_at: toIsoOrNull(data.expirationAt),
        last_event_type: type,
        raw_event: event,
        updated_at: nowIso,
    };
    if (mapping.timestampColumn === "started_at") {
        row.started_at = toIsoOrNull(data.purchasedAt) ?? nowIso;
    } else if (mapping.timestampColumn === "renewed_at") {
        row.renewed_at = toIsoOrNull(data.purchasedAt) ?? nowIso;
    } else if (mapping.timestampColumn === "cancelled_at") {
        row.cancelled_at = nowIso;
    } else if (mapping.timestampColumn === "refunded_at") {
        row.refunded_at = nowIso;
    }

    const upsertRes = await supabase
        .from("user_subscriptions")
        .upsert(row, { onConflict: "app_user_id" });
    if (upsertRes.error) {
        console.error("user_subscriptions upsert failed", upsertRes.error);
        return new Response("DB error", { status: 500 });
    }

    return new Response("ok", { status: 200 });
});
