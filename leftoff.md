# Left Off

**Last updated:** 2026-04-04

## Just Completed
- Expanded onboarding for ICP segmentation: gender, social context, discovery source questions
- Expanded quiz options (Quiz 1: 6 options, Quiz 2: 5 options, Quiz 3: 5 options, Goals: 9 options)
- Personalized scare screen based on Quiz 1 answer (6 variants)
- Age range expanded to 13-99, gender-neutral copy throughout
- Supabase migration applied (gender, social_context, discovery_source columns)
- Build 5 archived and uploaded to App Store Connect / TestFlight
- Onboarding flag reset in Supabase for testing
- User research synthesis updated to n=18 with two ICP segments (A: self-improvement, B: sorority/overthinkers)
- Created "Social IQ Pro" paywall (ID 203822) from Sharpen template with annual ($29.99) + weekly ($4.99)
- Swapped both "Onboarding Paywall" and "Lesson Locked" campaigns to Social IQ Pro (100% treatment)
- Enabled Apple auth provider in Supabase (Client ID: com.jonathanchamberlin.Social-IQ)
- TestFlight internal testing group "Dev Testing" created, build added, tester invited

## Unfinished
- Apple Sign In not yet verified end-to-end on TestFlight (provider was just enabled — needs test)
- `transaction_abandon` campaign has no placement and only a holdout variant — needs paywall + placement configured
- Phase 2: Verify Apple Sign In + Supabase persistence (ship-blocker) — test sign-in, check Supabase row, delete/reinstall/re-sign-in
- Phase 3: Verify Mixpanel events fire correctly
- Phase 4: Confirm payment pipeline (Paid Apps agreement, Small Business Program enrollment)
- Paywall copy still says "Get Sharpen+" — needs Social IQ branding in Superwall editor

## Next Up
- Test Apple Sign In on TestFlight build (should work now that Supabase provider is enabled)
- Walk through full onboarding on device, verify data in Supabase
- Delete/reinstall persistence test
- Mixpanel event verification
- Payment pipeline setup

## Blockers
- Rotate Superwall secret key (`sk_4238...`) — previously committed to git
