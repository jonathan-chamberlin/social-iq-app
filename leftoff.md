# Left Off

**Last updated:** 2026-04-19

## Unfinished
- **Build 29 uploaded to TestFlight** (Delivery UUID `310c2433-ee54-473c-8755-c974f3420bf6`) addressing App Review guideline 4.0 rejection (removed name TextField after Sign in with Apple). Waiting on processing (~5-15 min), then must attach to submission `bc9b1a63-d94e-483d-94f7-4f80c114f7d8` and reply to App Review explaining the silent `appleFirstName` → Supabase pipeline is preserved.
- `SuperwallService.identify(userId:)` added but not yet tested on TestFlight
- Small Business Program enrollment submitted, waiting for confirmation email
- `transaction_abandon` campaign has no placement, only holdout variant
- Views over 100 lines not yet split: SettingsView (171), HomeView (207), LessonView (138), LessonCompletionView (129)
- 0 test files exist - 10 testable types need test coverage
- **Offline loading path** — implemented timeouts + cached fallback; needs real-device TestFlight verification (enable airplane mode after a prior sign-in and relaunch)
- **CWOOP content-craft panel** — drafted into Notion task `347afe0d-cf03-80e4-bf7d-fcb90ed2dd09`; needs vividness test during morning CWOOPP (does the "hand moves to bookmarks" pull feel physiologically real?), then paste into Goal Image Scripts toggle on page 330afe0d… if it holds

## Next Up
- Confirm build 29 finishes processing in App Store Connect
- Reply to App Review in App Store Connect with the explanation above
- Once approved: create Bitly attribution links per channel
- **Lesson UX: sticky "See why" button** - pin to bottom of screen after correct answer
- **Reddit Seeding Launch** - Notion task `33dafe0d-cf03-8108-9c31-d3cdfea75a23`
- **AI UGC Tool Test** - Notion task `33dafe0d-cf03-8162-826b-ddced947353e`
- Add unit tests for ViewModels and Services
- **Short-form craft sprint** — 4 reels in 7 days during App Store wait; craft-input capped at 2h total; retention data per reel

## Blockers
- App Store approval pending Apple re-review of build 29
