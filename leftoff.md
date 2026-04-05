# Left Off

**Last updated:** 2026-04-05

## Unfinished
- `transaction_abandon` campaign has no placement, only holdout variant
- Superwall paywall shows wrong pricing/period ("0 Months", $4.99/0 months) because Superwall can't read local StoreKit config metadata — will self-resolve when real products exist in App Store Connect after Paid Apps agreement
- Debug subscription toggle (`#if DEBUG`) is in the code — long-press greeting to activate. Revert before release builds.

## Next Up
- Create a Google form for feedback, then add button in app so people can submit it
- Build onboarding funnel in Mixpanel by step_name
- After Paid Apps agreement activates: verify actual product pricing on Superwall paywalls, test sandbox purchase on device via TestFlight, enroll in Small Business Program

## Blockers
- **No Paid Apps agreement yet** — Apple Support case opened (ID: 102861544160). DPLA already accepted (March 30 → April 4). Apple's own docs say Paid Apps agreement should appear in App Store Connect but it's not showing. Likely a display glitch or stale cache on Apple's side. Waiting on Apple Support response.

## Feature Ideas
- Support multiple correct answers per question — different answers could be correct for different personality types (e.g., dominant/outgoing vs passive/introverted), since there's more than one valid way to handle a social situation
