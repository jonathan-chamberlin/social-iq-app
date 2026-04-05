# Left Off

**Last updated:** 2026-04-04

## Unfinished
- `lesson_locked_tap` — defined in AnalyticsEvent but not wired up in any view
- `paywall_presented` / `subscription_started` — defined but not fired from code
- Paywall copy still says "Get Sharpen+" — customize in Superwall editor
- `transaction_abandon` campaign has no placement, only holdout variant
- Old Example Paywall (ID 195191) can be archived
- Superwall secret key rotated (2026-04-04) — new key in `.env`, old `sk_4238...` is dead
- `AppConfig.swift` is gitignored — `shouldAutoOpenLesson1Key` constant added but won't be tracked; move UserDefaults keys to a non-ignored constants file

## Next Up
- Verify new Mixpanel events in dashboard from Build 6 TestFlight usage
- Build onboarding funnel in Mixpanel by step_name
- Wire up `lesson_locked_tap` in HomeView when locked lesson is tapped
- After Paid Apps agreement activates: verify prices on paywall, test sandbox purchase, enroll in Small Business Program

## Blockers
- **No Paid Apps agreement yet** — option hasn't surfaced in App Store Connect Business tab
