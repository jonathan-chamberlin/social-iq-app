# Left Off

**Last updated:** 2026-04-13

## Unfinished
- **Superwall paywall Terms/Privacy links not tappable** - Added "Terms of Use" and "Privacy Policy" text elements with Open URL tap behaviors to the Superwall paywall template, but tapping them on iOS simulator does nothing. Research says approach is correct but simulator has known touch limitations. Need to verify on physical device, or switch to standalone tappable elements (not inline in Text Container) with larger hit areas.
- **New build not yet uploaded to TestFlight** - Code changes (Terms of Use link in SettingsView + AppConstants) require archive + upload before resubmission
- `SuperwallService.identify(userId:)` added but not yet tested on TestFlight
- Small Business Program enrollment submitted, waiting for confirmation email
- `transaction_abandon` campaign has no placement, only holdout variant
- Views over 100 lines not yet split: SettingsView (171), HomeView (207), LessonView (138), LessonCompletionView (129)
- 0 test files exist - 10 testable types need test coverage

## Completed This Session
- **Fixed 5.1.2(i) ATT rejection** - Unchecked "Advertising Data" in ASC App Privacy (app doesn't track). "Data Used to Track You" section removed from product page.
- **Fixed 3.1.2(c) metadata** - Added Terms of Use (EULA) + Privacy Policy URLs to App Description in ASC. License Agreement already set to Apple's Standard License Agreement. Privacy Policy URL already set.
- **Added Terms of Use link in-app** - Added `termsOfUseURL` to AppConstants (Apple standard EULA), added "Terms of Use (EULA)" link to SettingsView Legal section
- **Added Terms/Privacy to Superwall paywall** - Added text elements with Open URL tap behaviors (not yet verified working)
- **Build passes** on simulator

## Next Up
- Fix Superwall paywall links (try larger standalone elements or verify on physical device)
- Archive + upload new build to TestFlight
- Test paywall links + identify() on TestFlight
- Resubmit to App Store Review
- Before resubmit: confirm `showResetSubscriptionButton = false` (already false)
- **Lesson UX: sticky "See why" button** - pin to bottom of screen after correct answer
- **Reddit Seeding Launch** - Notion task `33dafe0d-cf03-8108-9c31-d3cdfea75a23`
- **AI UGC Tool Test** - Notion task `33dafe0d-cf03-8162-826b-ddced947353e`
- Add unit tests for ViewModels and Services

## Blockers
- App Store approval blocked until 3.1.2(c) in-app links verified working + new build submitted
