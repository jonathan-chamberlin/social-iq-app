# Left Off

**Last updated:** 2026-04-08

## Unfinished
- App Store Review v1.0 submitted, waiting for approval (up to 48 hours)
  - Review status: https://appstoreconnect.apple.com/apps/6761561557/distribution/reviewsubmissions/details/bc9b1a63-d94e-483d-94f7-4f80c114f7d8
- Small Business Program enrollment submitted, waiting for confirmation email
- `transaction_abandon` campaign has no placement, only holdout variant
- AppConfig.swift was force-added to git (was gitignored for secrets) - verify it should stay tracked
- Views over 100 lines (LessonView 286, HomeView 244, LessonCompletionView 178) not yet split into subcomponents
- 0 test files exist - 10 testable types need test coverage

## Next Up
- Monitor App Store Review and respond to any rejection feedback
- Once approved: create Bitly attribution links per channel
- Split LessonView into coordinator + extracted subcomponents
- Add unit tests for ViewModels (AuthViewModel, LessonViewModel) and Services
- Enrich `app_opened` with `days_since_last_open` property for retention curves
- Add `explanation_expanded` event to measure answer explanation engagement

## Blockers
- None
