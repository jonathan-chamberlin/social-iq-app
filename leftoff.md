# Left Off

**Last updated:** 2026-04-26 (later session)

## Binding constraint
**Zero users. Content/videos is the proven distribution lever. Ship videos, not lessons.**

App launched 2026-04-20. Within 3 days, one data point from Chloe (romantic interest, used Jonathan's phone mid-date, skipped onboarding, clicked out at Q2) was about to anchor a multi-day lesson overhaul before a single reel shipped. Jonathan named the pattern himself: "more and more stuff has been happening before I make videos." That's the diagnostic — trust it.

**The "no right answer" signal IS real** (3/3 ICP-female, structural not noise). But you can't fix retention on a cohort that doesn't exist. Content produces ICP-female users whose actual install/engage/churn behavior will confirm or disconfirm this better than 20 more research sessions. Park the lesson overhaul. Revisit at monthly review, or sooner only if a live paying ICP-female churns citing this reason specifically.

**Positioning = scripting.** Chloe asked who the app is for; Jonathan couldn't answer cleanly. The fix is not a positioning doc written in advance — it's writing 10 reel hooks and watching which framing survives contact with the feed. Doc-work avoids the articulation under the guise of preparing for it.

**Next action: write and shoot reels.** Start with `content/reel-scripts/2026-04-21-batch.md` (5 scripts queued). Batch-shoot same-day.

## Unfinished
- **`/ship-store` Phase 3 gate — device smoke test** — build 33 (1.0.2) uploaded and VALID in ASC (`BUILD_ID=2f8e59dc-616a-40d2-a139-5c21010ded4c`). Waiting on Jonathan's "go" after smoke-testing on iPhone 16 Pro (onboarding → lesson 1 → paywall → new Raves lesson at position 3 → new Climbing Flirt lesson at position 7 → Raves SPEAK step C triggers Explain button). Next: Phases 4–8 (find_version_context → swap_build → resolve_compliance → update_reviewer_notes/whats_new → set_release_type MANUAL → submit_for_review). Notion task: `349afe0dcf038050a308ef447b3c6733`.

## Context for next session
- 1.0.1 (build 32) is already **READY_FOR_SALE** — live on the App Store
- 1.0.2 (build 33) is the in-flight release — two new dating lessons added this session
- `VERSION_ID` for 1.0.2: `31a343ce-ed6d-46ad-8b03-92fb28e04ea0` (will need to re-fetch in next session via `find_version_context.py`)
- Marketing version 1.0.2 is committed and pushed (`585ffc2`)
- All lesson content committed (`985134c`) and pushed
- Archives at `archives/SocialIQ-1.0.2-33.xcarchive` and `archives/export-33-1.0.2/`
- **Creator positioning locked** — `references/creator-positioning.md` (one-pager: pillar, operating model, decision filter). Research split into `references/viral-hooks-research.md` (12 principles + 7 teardowns) and `references/social-iq-content-playbook.md` (platform handling, applied positioning, 6 ranked hook templates). Use the 4-question decision filter before posting reels.
- **Mixpanel sim-filter hook** — `.claude/settings.json` now has a PreToolUse hook on `mcp__claude_ai_Mixpanel__.*` that reminds future sessions to filter `$model != "arm64"` on insights/funnels/retention queries. Real-device 30d snapshot taken this session: onboarding 65% complete (17/26), step 13→14 looks like a missing-instrumentation cliff (17 → 1), real funnel cliff is lesson 3 → lesson 4 (17 starts → 6), D1 retention 31% on app_opened.

## Passive monitoring
- **First real subscription webhook** — when next real user buys, query `SELECT app_user_id, event_type, received_at FROM user_subscription_events ORDER BY received_at DESC LIMIT 10;` — plain UUID = fix live; `$SuperwallAlias:*` = regression.
- **Two pre-existing warnings in `SuperwallService.swift:124`** — unused `restorationResult` + spurious `try`. Drive-by cleanup, not urgent.

## Historical unfinished (pre-session)
- `transaction_abandon` campaign has no placement, only holdout variant
- Views over 100 lines not yet split: SettingsView (171), HomeView (207), LessonView (138), LessonCompletionView (129)
- 0 test files exist — 10 testable types need test coverage
- **Offline loading path** — implemented timeouts + cached fallback; needs real-device TestFlight verification (enable airplane mode after a prior sign-in and relaunch)
- **Dylan triage — prioritized action list:**
  2. **Defer sign-in to paywall accept** — onboarding + Lesson 1 run anonymous. ~1 day.
  3. **2s locked-continue timer on reactive onboarding screens** — scare, uplift, socialProof, chart, bridgeToPaywall. Trivial.
  4. **Per-answer reactive beats after quiz questions** — bigger lift. Next week if 1–3 move the needle.
  5. **Restructure lesson flow to story-first (Kahoot-style)** — biggest lift. Park until 1–4 validate.
- **Superwall dashboard bundle_id trailing whitespace bug** — fixed. File bug report with Superwall support.

## Parked (revisit at monthly review or on specific trigger)
- **Chloe (Session 19) / lesson overhaul** — see `user-research/transcripts/19_inperson_chloe.md`. Lighter palette, branching format, "no single right answer" (3/3 ICP-female). **Parked** because zero users = no retention to fix. Trigger to revisit: monthly review, OR a live paying ICP-female churns citing this specifically. Never hand the app to a tester again without onboarding.

## Parked: Phantom UUID Auth Investigation
- **Symptom**: 5 users in App Store build 32 (1.0.1) hit 401s on `lesson_progress` writes between 2026-04-23 18:50 and 2026-04-24 01:26 UTC. Defensive session guard now in place in `LessonProgressService` — affected writes skip cleanly.
- **Root cause status**: Unconfirmed. Scenario B verified — phantom UUIDs never existed in `auth.users`, never appeared in `audit_log_entries`, never matched `user_profiles.device_user_id`.
- **Top hypotheses**:
  1. Stale Keychain session from a prior Supabase project (URL or anon key changed historically) — SDK returns cached session that decodes locally but signs a UUID Supabase never issued.
  2. Supabase Swift SDK `signInWithIdToken` bug returning `session.user` without server round-trip.
  3. `AuthService.restoreSession` `currentSession` fallback returning a JWT for a server-deleted user (less likely — would leave audit traces).
- **Next probe options**:
  1. Add temporary logging around every `authState = .signedIn(...)` assignment with the UUID seen, ship TestFlight, wait for next phantom event.
  2. Trace a Mixpanel `$user_id` for an affected user back to their sign-in event to see what the SDK returned.
  3. Ask an affected user for Keychain contents (highest signal, hardest to get).
- **Trigger to revisit**: Either (a) `lesson_write_skipped` Mixpanel event volume rises above ~5/day sustained, (b) a paying user reports broken progress, or (c) monthly review.
- **Why parked**: Defensive guard mitigates user-facing impact. Full investigation is multi-day and not on the critical path to user acquisition.

## Next Up
- read this page with notion mcp https://www.notion.so/jchamberlin/Post-content-fixes-funnel-retention-improvements-revisit-after-first-content-driven-install-wav-34cafe0dcf0380328120d5dff8c0b506?source=copy_link
- **Write + shoot 5 reels** — `content/reel-scripts/2026-04-21-batch.md`. Scripting IS the positioning work. Batch-shoot same-day.
- **Once build 33 is approved and released:** update on phone → verify new lessons render correctly for real users → monitor Mixpanel for lesson_started events on lesson-6 and lesson-7
- **Mixpanel internal-user filter — manual follow-up:**
  - Add annotation: "App Store 1.0.2 launch — two new dating lessons"
  - Wait for Lexicon to index `is_internal` / `build_type`, then create "Real users" cohort
- **Lesson UX: sticky "See why" button** — pin to bottom of screen after correct answer
- **Reddit Seeding Launch** — Notion task `33dafe0d-cf03-8108-9c31-d3cdfea75a23`
- **AI UGC Tool Test** — Notion task `33dafe0d-cf03-8162-826b-ddced947353e`
- **Push notifications — GATED on >20 premium users.** Trigger to revisit: premium_users > 20. Archived plan: Notion task `34bafe0d-cf03-8025-953d-f766b78054e2`.
- **Short-form craft sprint** — 5 scripts at `content/reel-scripts/2026-04-21-batch.md`. Batch-shoot all 5 same-day.

## Blockers
- **Jonathan's "go" after device smoke test** — blocks ship-store Phases 4–8.
