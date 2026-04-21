# Left Off

**Last updated:** 2026-04-21

## Unfinished
- **Build 29 uploaded to TestFlight** (Delivery UUID `310c2433-ee54-473c-8755-c974f3420bf6`) addressing App Review guideline 4.0 rejection (removed name TextField after Sign in with Apple). Waiting on processing (~5-15 min), then must attach to submission `bc9b1a63-d94e-483d-94f7-4f80c114f7d8` and reply to App Review explaining the silent `appleFirstName` → Supabase pipeline is preserved.
- `SuperwallService.identify(userId:)` added but not yet tested on TestFlight
- Small Business Program enrollment submitted, waiting for confirmation email
- `transaction_abandon` campaign has no placement, only holdout variant
- Views over 100 lines not yet split: SettingsView (171), HomeView (207), LessonView (138), LessonCompletionView (129)
- 0 test files exist - 10 testable types need test coverage
- **Offline loading path** — implemented timeouts + cached fallback; needs real-device TestFlight verification (enable airplane mode after a prior sign-in and relaunch)
- **CWOOP content-craft panel** — drafted into Notion task `347afe0d-cf03-80e4-bf7d-fcb90ed2dd09`; needs vividness test during morning CWOOPP (does the "hand moves to bookmarks" pull feel physiologically real?), then paste into Goal Image Scripts toggle on page 330afe0d… if it holds
- **Dylan 2026-04-20 feedback action items not yet extracted** — appended his follow-up to `user-research/transcripts/07_remote_dylan.md`. Themes: kill sign-in friction, enforce 2s wait on social-proof screens, add "Get Started" welcome screen before first question (Quittr-style), story-arc onboarding (problem → graph/review → "calculating plan"), Kahoot-style lesson UI (story first, then MCQ), ad prices (clarify), in-app feedback discoverability. Decide which to act on vs. park.
- **Dylan triage — prioritized action list** (see 2026-04-20 analysis in conversation; structurally your onboarding already matches Quittr's 11-step flow, so these are layered fixes not a rewrite):
  1. **Add welcome / "Get Started" screen as step 0** — branded hero, one-line promise, single CTA. Reframes the first moment as voluntary commitment, shows product soul before the interrogation, fixes App-Store-to-onboarding promise mismatch. ~1 afternoon, 1 file.
  2. **Defer sign-in to paywall accept** — onboarding + Lesson 1 run anonymous. Store onboarding answers in UserDefaults, alias Mixpanel distinct_id on Sign in with Apple, push to Supabase post-auth. Solves Dylan's "no reason to need an account" without losing pro/purchase attribution. ~1 day. Files: `OnboardingService`, `AuthService`, `AnalyticsService`, `Social_IQApp` boot path.
  3. **2s locked-continue timer on reactive onboarding screens** — scare, uplift, socialProof, chart, bridgeToPaywall. Forces the emotional beat to land before dismissal. Trivial — timer + disabled button state.
  4. **Per-answer reactive beats after quiz questions** — each quiz answer triggers a tailored micro-screen (graph "73% of users with this struggle improved in 14 days" OR matched testimonial "Marcus, 21, same answer"). Transforms questionnaire into conversation. Bigger lift: content writing + 3–6 new micro-screens + answer→beat mapping. Next week if items 1–3 move the needle on user tests.
  5. **Restructure lesson flow to story-first (Kahoot-style)** — present scenario in isolation first, build tension, then reveal MCQ. Current flow shows all 4 options simultaneously with the prompt. Separate initiative — biggest lift, affects every lesson + LessonView architecture. Park until 1–4 validate.
- **Superwall dashboard bundle_id trailing whitespace bug** — 85 spaces padded to registered bundle_id on save, causing Test Mode popup on App Store build. User fixed via dashboard UI. File bug report with Superwall support.

## Next Up
- **Review + commit /improve uncommitted changes** (intent: Stop Superwall from silently throwing production paywalls into Test Mode because the dashboard stored 85 trailing spaces on the bundle ID). Includes: 5 Swift refactors (magic opacity → Theme.Opacity.*, 6 AnalyticsService.track calls moved from LessonView to LessonViewModel), CLAUDE.md Gotcha + superwall-campaigns skill troubleshooting entry, mixpanel-taxonomy factual fix (`track()` does NOT call `flush()` per-event), new `daily-log.md`, `.claude/improve-lastrun` bump.
- **Verify Test Mode popup cleared on real iPhone after kill + relaunch** (user reported it worked; confirm repeatable on App Store version if needed)
- **Mixpanel internal-user filter — manual follow-up**:
  - Add annotation on Reports → click 2026-04-20 → "App Store launch — 16:00 UTC" (MCP has no annotation tool)
  - Wait for Lexicon to index `is_internal` / `build_type` super properties (~5–15 min), then create cohort "Real users" where `is_internal != true` and set as default filter on funnel dashboards
  - Code change in `Services/AnalyticsService.swift` tags every future event with `build_type` (debug/testflight/app_store) + `is_internal` bool — ships with next build
  - Script `scripts/mixpanel/retro_tag_internal_users.py` already committed 26 pre-launch profiles as `is_internal=true`. 94 anonymous event-only distinct_ids (126 total − 32 profiles) cannot be retro-tagged; filter those out via date-range only
- Confirm build 29 finishes processing in App Store Connect
- Reply to App Review in App Store Connect with the explanation above
- App Store Connect attribution links created for all 6 channels (see `references/attribution-links.md`) — wire into future `reddit-seeding` skill so agents never reconstruct URLs
- **Lesson UX: sticky "See why" button** - pin to bottom of screen after correct answer
- **Reddit Seeding Launch** - Notion task `33dafe0d-cf03-8108-9c31-d3cdfea75a23`
- **AI UGC Tool Test** - Notion task `33dafe0d-cf03-8162-826b-ddced947353e`
- Add unit tests for ViewModels and Services
- **Short-form craft sprint** — 4 reels in 7 days during App Store wait; craft-input capped at 2h total; retention data per reel
- Triage Dylan's 2026-04-20 feedback into real tasks vs. parked

## Blockers
- App Store approval pending Apple re-review of build 29
