# Left Off

**Last updated:** 2026-04-21

## Unfinished
- **Passive monitoring for first real subscription-webhook delivery** — identify-timing half is CONFIRMED LIVE on build 31: launched app → dismissed a paywall → Superwall dashboard search for Supabase UUID `e38bd3f8-d645-4367-a0e9-c065beb986b2` resolved to a user record with the `paywall_close` event tagged to that id (not `$SuperwallAlias:*`). So the SDK is now correctly propagating the Supabase UUID as `originalAppUserId` on real events. Only untested link remaining is webhook payload shape on a real store transaction. When the next real user buys, query `SELECT app_user_id, event_type, received_at FROM user_subscription_events ORDER BY received_at DESC LIMIT 10;` — if `app_user_id` is a plain UUID, full fix is live; if `$SuperwallAlias:*`, regression.

  Note for future reference: `Superwall.shared.identify(userId:)` is a local-only SDK call (no network request); Superwall's server only learns a user exists once a trackable event (paywall presentation, purchase, etc.) fires tagged with that id. To verify identify-timing changes in the dashboard without waiting for a purchase, trigger any paywall and dismiss it.
- **Three uncommitted skill edits pending review** —
  - `.claude/skills/supabase-schema-rls/SKILL.md` (Svix-signed synthetic webhook verification recipe)
  - `.claude/skills/superwall-campaigns/SKILL.md` (accepted `filter_types` values: no `pause`/`refund`/`trial_start`/`trial_conversion`)
  - `.claude/skills/testflight-deploy/SKILL.md` (query-ASC-first logic before `agvtool` bump; build numbers are global-monotonic per app)
  All three are operational knowledge worth keeping. Diff + commit when convenient.
- **Two pre-existing warnings in `SuperwallService.swift:124`** — unused `restorationResult` return value + spurious `try`. Drive-by cleanup, not urgent.
- **`.claude/improve-artifacts/*` and `.claude/settings.local.json` modified** — leftover from pre-session /improve run. Untracked `daily-log.md` at repo root. `git diff` + decide to commit or discard.
- **First real end-to-end run of `ship-store`** — build 31 on TestFlight but production 1.0.1 submission hasn't run through the skill. ASC 1.0.1 row exists in `Prepare for Submission`. Next step: say "ship store" to drive `/ship` → TestFlight processing poll → physical-device smoke gate → swap build 31 onto ASC 1.0.1 row → metadata → submit for review.

## Historical unfinished (pre-session)
- `transaction_abandon` campaign has no placement, only holdout variant
- Views over 100 lines not yet split: SettingsView (171), HomeView (207), LessonView (138), LessonCompletionView (129)
- 0 test files exist — 10 testable types need test coverage
- **Offline loading path** — implemented timeouts + cached fallback; needs real-device TestFlight verification (enable airplane mode after a prior sign-in and relaunch)
- **CWOOP content-craft panel** — drafted into Notion task `347afe0d-cf03-80e4-bf7d-fcb90ed2dd09`; needs vividness test during morning CWOOPP, then paste into Goal Image Scripts toggle on page 330afe0d… if it holds
- **Dylan triage — prioritized action list** (#1 Get Started screen DONE in 045632e):
  2. **Defer sign-in to paywall accept** — onboarding + Lesson 1 run anonymous. ~1 day. Files: `OnboardingService`, `AuthService`, `AnalyticsService`, `Social_IQApp` boot path. Now compatible with subscription-state since device UUID identity survives pre-sign-in purchases.
  3. **2s locked-continue timer on reactive onboarding screens** — scare, uplift, socialProof, chart, bridgeToPaywall. Trivial.
  4. **Per-answer reactive beats after quiz questions** — bigger lift. Next week if 1–3 move the needle.
  5. **Restructure lesson flow to story-first (Kahoot-style)** — biggest lift. Park until 1–4 validate.
- **Superwall dashboard bundle_id trailing whitespace bug** — fixed via dashboard UI. File bug report with Superwall support.
- **Untracked `content/reel-scripts/2026-04-21-batch.md`** — 5 reel scripts (Griffin body language, Hudson anxiety, Quest rude worker, Nick's 12-page plan, gym compliments). Not tracked.

## Next Up
- **Once build 31 is VALID on TestFlight:** update on phone → fresh test Apple ID → sandbox purchase → verify rows in both subscription tables. This is the last piece of the serene-wandering-cook plan.
- **Mixpanel internal-user filter — manual follow-up:**
  - Add annotation on Reports → click 2026-04-20 → "App Store launch — 16:00 UTC" (MCP has no annotation tool)
  - Wait for Lexicon to index `is_internal` / `build_type` super properties, then create cohort "Real users" where `is_internal != true` and set as default filter on funnel dashboards
- **Lesson UX: sticky "See why" button** — pin to bottom of screen after correct answer
- **Reddit Seeding Launch** — Notion task `33dafe0d-cf03-8108-9c31-d3cdfea75a23`
- **AI UGC Tool Test** — Notion task `33dafe0d-cf03-8162-826b-ddced947353e`
- Add unit tests for ViewModels and Services
- **Short-form craft sprint** — 5 scripts drafted at `content/reel-scripts/2026-04-21-batch.md`. Next: batch-shoot all 5 same-day with one outfit swap (between #2 and #3), fixed lighting, hand landmarks. Do NOT edit same-day — batch-edit separately. Craft-input capped at 2h total; retention data per reel.
- Triage Dylan's 2026-04-20 feedback into real tasks vs. parked

## Blockers
- **Build 31 processing on ASC** — soft-blocks real sandbox verification only. App builds and runs fine locally regardless. Expected VALID within 5–15 min of 23:22 UTC upload.
