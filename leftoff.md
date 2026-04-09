# Left Off

**Last updated:** 2026-04-09

## Unfinished
- Build 18 uploaded to TestFlight - needs on-device verification before resubmitting to App Review
- Verification steps: delete account data > sign in with Apple > confirm name pre-fills in onboarding > verify Settings screen (restore purchases, privacy policy, support, delete account)
- Small Business Program enrollment submitted, waiting for confirmation email
- `transaction_abandon` campaign has no placement, only holdout variant
- AppConfig.swift was force-added to git (was gitignored for secrets) - verify it should stay tracked
- Views over 100 lines not yet split: LessonView (138), HomeView (211), LessonCompletionView (129), SettingsView (138)
- 0 test files exist - 10 testable types need test coverage
- Theme.Opacity constants adopted across all views (37 replacements in 18 files)

## Next Up
- Verify build 18 on device, then resubmit to App Store Review
- **Reddit Seeding Launch** - full details in Notion task page content (task ID: `33dafe0d-cf03-8108-9c31-d3cdfea75a23`)
- **AI UGC Tool Test** - full details in Notion task page content (task ID: `33dafe0d-cf03-8162-826b-ddced947353e`)
- Once approved: create Bitly attribution links per channel
- Add unit tests for ViewModels (AuthViewModel, LessonViewModel, OnboardingViewModel) and Services

## Blockers
- None

## Reference
- TestFlight public link: https://testflight.apple.com/join/x9BESNVN
