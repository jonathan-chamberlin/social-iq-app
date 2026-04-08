# Left Off

**Last updated:** 2026-04-07

## Unfinished
- `transaction_abandon` campaign has no placement, only holdout variant
- Superwall paywall shows wrong pricing/period ("0 Months", $4.99/0 months) — will self-resolve when real products exist in App Store Connect
- Debug subscription toggle (`#if DEBUG`) is in the code — long-press greeting to activate. Compiled out of release builds, safe to keep.
- Deleted PaywallView.swift and UserProfile.swift still referenced in .pbxproj — need to remove red file entries in Xcode before next archive
- `onboarding_abandoned` event: code is correct but hasn't been verified in a live test (fires on app background during onboarding)

## Next Up
- Implement remaining quick wins: daily streak counter (#5), scenario context illustrations (#8)
- After Paid Apps agreement activates: verify actual product pricing on Superwall paywalls, test sandbox purchase on device via TestFlight, enroll in Small Business Program
- Once App Store link is live: create Bitly attribution links per channel (one per channel, not per post)

## Blockers
- None
