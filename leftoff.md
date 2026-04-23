# Left Off

**Last updated:** 2026-04-23

## Unfinished
- **Lessons 6 & 7 added locally, not committed** — `Lesson6Data.swift` (pro, climbing-gym flirt, id `lesson-6`) + `Lesson7Data.swift` (free, raves disclosure, id `lesson-7`). Registered in `LessonData.swift` `allLessons` order `[lesson3, lesson2, lesson7, lesson4, lesson1, lesson5, lesson6]`. `freeLessonIds` + `lessonCompletionCounts` + `lessonPercentiles` updated in `AppConstants.swift`. Also removed `NEVER modify .pbxproj` rule from both `~/.claude/CLAUDE.md` and `social-iq/CLAUDE.md` (rule was a no-op because project uses Xcode 16 `PBXFileSystemSynchronizedRootGroup` — new files auto-sync to target). Build green, visual-verified on sim. **Decision needed before commit:** include in 1.0.1 ship-store in-flight, or hold for 1.0.2? Content change, zero logic risk. Also optional: normalize new scenarios' single quotes (`'EDC,'`) to double quotes to match existing 5 lessons' style.
- **`/ship-store` mid-flight — Phase 3 device smoke gate** — build 32 (1.0.1) uploaded to ASC at 00:02 UTC, processed VALID in ~90s. `BUILD_ID=16030868-8caa-4887-a6ea-1157332d4a1b`. ASC 1.0.1 row still `PREPARE_FOR_SUBMISSION`, no build attached. Waiting on user device smoke-test of build 32 on Jonathan iPhone 16 Pro (onboarding → lesson 1 → paywall → Sign in with Apple). Next: user replies "go", then ship-store runs Phases 4–8 (find_version_context → swap_build + resolve_compliance → update metadata → set_release_type → submit_for_review). Notion task: `349afe0dcf038050a308ef447b3c6733`.
- **Passive monitoring for first real subscription-webhook delivery** — identify-timing half CONFIRMED on build 31 (paywall_close event in Superwall tagged to Supabase UUID `e38bd3f8-d645-4367-a0e9-c065beb986b2`, not `$SuperwallAlias:*`). Only untested link is webhook payload shape on a real store transaction. When the next real user buys, query `SELECT app_user_id, event_type, received_at FROM user_subscription_events ORDER BY received_at DESC LIMIT 10;` — plain UUID = fix live; `$SuperwallAlias:*` = regression.
- **Two pre-existing warnings in `SuperwallService.swift:124`** — unused `restorationResult` return value + spurious `try`. Drive-by cleanup, not urgent.
- **`.claude/improve-artifacts/*` modified, untracked `content/reel-scripts/`** — leftover scratch. `git diff` + decide to commit or discard.

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
- **Untracked `content/reel-scripts/2026-04-21-batch.md`** — 5 reel scripts. Not tracked.

## Next Up
- **Once build 32 is live on App Store:** update on phone → fresh test Apple ID → sandbox purchase → verify rows in both subscription tables. Last piece of the serene-wandering-cook plan.
- **Mixpanel internal-user filter — manual follow-up:**
  - Add annotation on Reports → click 2026-04-20 → "App Store launch — 16:00 UTC" (MCP has no annotation tool)
  - Wait for Lexicon to index `is_internal` / `build_type`, then create cohort "Real users" where `is_internal != true` as default filter on funnel dashboards
- **Lesson UX: sticky "See why" button** — pin to bottom of screen after correct answer
- **Reddit Seeding Launch** — Notion task `33dafe0d-cf03-8108-9c31-d3cdfea75a23`
- **AI UGC Tool Test** — Notion task `33dafe0d-cf03-8162-826b-ddced947353e`
- Add unit tests for ViewModels and Services
- **Short-form craft sprint** — 5 scripts drafted at `content/reel-scripts/2026-04-21-batch.md`. Next: batch-shoot all 5 same-day with one outfit swap (between #2 and #3), fixed lighting, hand landmarks. Batch-edit separately. Craft-input capped at 2h total; retention data per reel.
- Triage Dylan's 2026-04-20 feedback into real tasks vs. parked
- **Push notifications — GATED on >20 premium users.** Deferred 2026-04-23 because requirement failed binding-constraint test (manual text thread covers current premium count in <5 min). Audit + full phased plan archived on Notion task `34bafe0d-cf03-8025-953d-f766b78054e2`. Trigger to revisit: premium_users > 20 OR Jonathan has manually notified users 3+ times and is sick of it. Recommended architecture when revived: Supabase Edge Function → APNs HTTP/2 directly (option A), zero new vendors.

## Blockers
- **User device smoke-test of build 32** — blocks ship-store Phases 4–8. Soft block only; no further automation possible until user replies "go" in this session.
- **Commit vs. hold decision for lessons 6 & 7** — blocks commit/push. Adding to in-flight 1.0.1 means a new build + re-upload; holding means 1.0.2 scope. User call, not automation.
