# Left Off

**Last updated:** 2026-04-09

## Unfinished
- App Store Review v1.0 rejected (Guideline 4.0.0 - Sign in with Apple name re-ask). Fix implemented, not yet deployed.
- Code changes ready but NOT on TestFlight yet:
  1. Sign in with Apple name pre-fill (extracts givenName, persists to Supabase, pre-fills onboarding)
  2. New Settings screen replacing Sign Out button (account deletion, restore purchases, privacy policy link, support link)
- App Privacy labels in App Store Connect need manual verification (Mixpanel, Superwall, Supabase disclosures)
- Small Business Program enrollment submitted, waiting for confirmation email
- `transaction_abandon` campaign has no placement, only holdout variant
- AppConfig.swift was force-added to git (was gitignored for secrets) - verify it should stay tracked
- Views over 100 lines (LessonView 286, HomeView 244, LessonCompletionView 178) not yet split into subcomponents
- 0 test files exist - 10 testable types need test coverage

## Next Up
- Verify App Privacy labels in App Store Connect (use Claude Chrome checklist prompt)
- Deploy to TestFlight, go through app on phone, delete account data, sign in with Apple, verify name is pre-filled in onboarding name field
- Resubmit to App Store Review
- **Reddit Seeding Launch** - full details in Notion task page content (task ID: `33dafe0d-cf03-8108-9c31-d3cdfea75a23`)
- **AI UGC Tool Test** - full details in Notion task page content (task ID: `33dafe0d-cf03-8162-826b-ddced947353e`)
- Once approved: create Bitly attribution links per channel
- Split LessonView into coordinator + extracted subcomponents
- Add unit tests for ViewModels (AuthViewModel, LessonViewModel) and Services

## Blockers
- None

## Reference
- TestFlight public link: https://testflight.apple.com/join/x9BESNVN
