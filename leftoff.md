# Left Off

**Last updated:** 2026-04-21

## Unfinished
- **Robust per-user subscription state (serene-wandering-cook plan)** — Phase 1 (identify timing) + Phase 2 (webhook → `user_subscriptions`) + Phase 3 (`current_subscription()` SQL helper) IMPLEMENTED. Migration `20260421200000_user_subscriptions.sql` applied to prod Supabase. Edge function `superwall-webhook` deployed (id `052e14cf-d5f0-419a-9aaa-e01c8e01e260`, verify_jwt=false). Superwall webhook endpoint registered (id `ep_3CfzzWldAKE6ijqasiuCAsG5JgR`) against URL `https://mobxxxxbsuuygwddjfom.supabase.co/functions/v1/superwall-webhook` with filter_types `[billing_issue, cancellation, expiration, initial_purchase, renewal, subscription_paused, uncancellation]`. NOT yet committed, NOT yet on TestFlight. **Manual step required:** set Supabase Edge Function secret `SUPERWALL_WEBHOOK_SECRET=whsec_gSxTziAOE2DdxU5lD68GQ+5mR7IHA8+Y` via Supabase dashboard → Project Settings → Edge Functions → Secrets (Supabase CLI not installed). Without this, every webhook will 500 on signature verification. Verification still pending: sandbox purchase → confirm `user_subscription_events` + `user_subscriptions` rows appear.
- **Lesson attempt tracking** — migration `lesson_progress_attempt_tracking` applied to prod Supabase, Swift wiring + Mixpanel property enrichment done, build clean, RPC verified against live DB with scratch row. NOT yet committed, NOT yet on TestFlight. 14 uncommitted files (see `git status`). Columns on existing 5 Terri rows are `attempt_count=0 / last_reached_question=null` (migration default, expected).
- **`ship-store` skill built and smoke-tested** (global, at `~/.claude/skills/ship-store/`). Invocable via "ship store", "ship to app store", "/ship-store". Orchestrates /ship → poll processing → device smoke test → version context → build swap → metadata patch → submit → poll approval → release. 11 scripts + 2 templates, all read-only scripts passed live-ASC smoke test (build 30 VALID, version 1.0 READY_FOR_SALE). NOT yet used end-to-end — first real run is the alpha test.
- **ASC state check** — only ONE version exists: 1.0 READY_FOR_SALE (id `2fe0f353-dba4-40f6-8296-3d8b045bca17`). No pending version row. Submission `bc9b1a63-...` from historical context is not surfacing via `/v1/apps/{id}/appStoreVersions`. To ship the attempt-tracking change through ship-store, first create a new version (e.g. 1.0.1) in the ASC UI — then `ship-store` can drive the rest via API.

## Historical unfinished (pre-session)
- **Build 29 uploaded to TestFlight** (Delivery UUID `310c2433-ee54-473c-8755-c974f3420bf6`, now showing as build 30 in ASC) addressing App Review guideline 4.0 rejection (removed name TextField after Sign in with Apple). Build is VALID and attached to version 1.0 READY_FOR_SALE.
- `SuperwallService.identify(userId:)` added but not yet tested on TestFlight
- Small Business Program enrollment submitted, waiting for confirmation email
- `transaction_abandon` campaign has no placement, only holdout variant
- Views over 100 lines not yet split: SettingsView (171), HomeView (207), LessonView (138), LessonCompletionView (129)
- 0 test files exist - 10 testable types need test coverage
- **Offline loading path** — implemented timeouts + cached fallback; needs real-device TestFlight verification (enable airplane mode after a prior sign-in and relaunch)
- **CWOOP content-craft panel** — drafted into Notion task `347afe0d-cf03-80e4-bf7d-fcb90ed2dd09`; needs vividness test during morning CWOOPP (does the "hand moves to bookmarks" pull feel physiologically real?), then paste into Goal Image Scripts toggle on page 330afe0d… if it holds
- **Dylan 2026-04-20 feedback action items not yet extracted** — appended his follow-up to `user-research/transcripts/07_remote_dylan.md`. Themes: kill sign-in friction, enforce 2s wait on social-proof screens, add "Get Started" welcome screen before first question (Quittr-style), story-arc onboarding (problem → graph/review → "calculating plan"), Kahoot-style lesson UI (story first, then MCQ), ad prices (clarify), in-app feedback discoverability. Decide which to act on vs. park.
- **Dylan triage — prioritized action list**:
  1. **Add welcome / "Get Started" screen as step 0** — branded hero, one-line promise, single CTA. ~1 afternoon, 1 file.
  2. **Defer sign-in to paywall accept** — onboarding + Lesson 1 run anonymous. ~1 day. Files: `OnboardingService`, `AuthService`, `AnalyticsService`, `Social_IQApp` boot path.
  3. **2s locked-continue timer on reactive onboarding screens** — scare, uplift, socialProof, chart, bridgeToPaywall. Trivial.
  4. **Per-answer reactive beats after quiz questions** — bigger lift. Next week if items 1–3 move the needle.
  5. **Restructure lesson flow to story-first (Kahoot-style)** — biggest lift. Park until 1–4 validate.
- **Superwall dashboard bundle_id trailing whitespace bug** — fixed via dashboard UI. File bug report with Superwall support.

## Next Up
- **Set `SUPERWALL_WEBHOOK_SECRET` in Supabase dashboard** (value above). Until done, the deployed webhook rejects every delivery.
- **Commit the subscription-state change separately from attempt-tracking** (different intents). Subscription-state intent: "Stop having to grant subscriptions manually because the Superwall dashboard attributes purchases to anonymous alias ids instead of my Supabase user id." Files: `AppConstants.swift`, `Services/{AnalyticsService,AuthService,SuperwallService}.swift`, `Social_IQApp.swift`, `ViewModels/AuthViewModel.swift`, `supabase/migrations/20260421200000_user_subscriptions.sql`, `supabase/functions/superwall-webhook/index.ts`.
- **TestFlight sandbox verification for subscription-state**: fresh test Apple ID → purchase weekly sub → within ~30s confirm a row appears in `user_subscription_events` with `event_type=initial_purchase`, `app_user_id=<supabase test user id>`, and that `user_subscriptions` has one row `status=active` with `expires_at ~7d` out.
- **Commit + TestFlight the lesson attempt tracking change**. Intent: "Stop flying blind on mid-lesson drop-off and lesson replays by writing attempt_count + last_reached_question to Supabase and fixing the abandon event so it fires on back/swipe-down, not just backgrounding."
- **Create a new App Store version row** (e.g. 1.0.1) in ASC UI so `ship-store` can drive the release for the next change.
- **First real run of `ship-store`** — use it to ship the attempt-tracking change once a new version exists. Fold any friction back into the scripts before the next release.
- **Review + commit /improve uncommitted changes** (intent: Stop Superwall from silently throwing production paywalls into Test Mode because the dashboard stored 85 trailing spaces on the bundle ID). Includes: 5 Swift refactors (magic opacity → Theme.Opacity.*, 6 AnalyticsService.track calls moved from LessonView to LessonViewModel), CLAUDE.md Gotcha + superwall-campaigns skill troubleshooting entry, mixpanel-taxonomy factual fix (`track()` does NOT call `flush()` per-event), new `daily-log.md`, `.claude/improve-lastrun` bump.
- **Mixpanel internal-user filter — manual follow-up**:
  - Add annotation on Reports → click 2026-04-20 → "App Store launch — 16:00 UTC" (MCP has no annotation tool)
  - Wait for Lexicon to index `is_internal` / `build_type` super properties (~5–15 min), then create cohort "Real users" where `is_internal != true` and set as default filter on funnel dashboards
- App Store Connect attribution links created for all 6 channels (see `references/attribution-links.md`) — wire into future `reddit-seeding` skill so agents never reconstruct URLs
- **Lesson UX: sticky "See why" button** - pin to bottom of screen after correct answer
- **Reddit Seeding Launch** - Notion task `33dafe0d-cf03-8108-9c31-d3cdfea75a23`
- **AI UGC Tool Test** - Notion task `33dafe0d-cf03-8162-826b-ddced947353e`
- Add unit tests for ViewModels and Services
- **Short-form craft sprint** — 5 scripts drafted at `content/reel-scripts/2026-04-21-batch.md` (Griffin body language, Hudson anxiety, Quest rude worker, Nick's 12-page plan, gym compliments). Next: batch-shoot all 5 same-day with one outfit swap (between #2 and #3), fixed lighting, hand landmarks. Do NOT edit same-day — batch-edit separately. Craft-input capped at 2h total; retention data per reel.
- Triage Dylan's 2026-04-20 feedback into real tasks vs. parked

## Blockers
- No pending App Store version row — must create one in ASC UI before `ship-store` can submit the attempt-tracking change.
