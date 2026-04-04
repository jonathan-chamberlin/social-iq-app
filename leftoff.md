# Left Off

**Last updated:** 2026-04-04

## Just Completed
- Build 5 on TestFlight, Dev Testing group configured
- Enabled Apple auth provider in Supabase
- Created "Social IQ Pro" paywall from Sharpen template, both campaigns swapped
- Subscription products configured in App Store Connect (annual $29.99 + weekly $4.99)
- Product localizations, availability (175 countries), group localization all set up
- Created testflight-deploy skill
- Accepted updated Developer Program License Agreement
- EU DSA compliance already active (27 countries)
- **Phase 2 PASSED:** Apple Sign In + Supabase persistence verified — sign-in creates data, delete/reinstall preserves account, single row confirmed

## Blockers
- **No Paid Apps agreement yet** — option hasn't surfaced in App Store Connect Business tab. Keep refreshing. Once it appears: set up bank, tax (W-9), contact info. May take 24-48h after setup to activate.

## Currently Active: Phase 3 — Verify Mixpanel Events

- Open Mixpanel dashboard → Events / Live View
- Trigger events on phone and verify they appear:
  - app_opened, onboarding_started, onboarding_step_completed, onboarding_completed
  - lesson_locked_tap, lesson_started, lesson_completed
- Check Users section — Supabase UUID should be distinct ID

## Unfinished
- Paywall copy still says "Get Sharpen+" — customize in Superwall editor
- `transaction_abandon` campaign has no placement, only holdout variant
- Old Example Paywall (ID 195191) can be archived
- Rotate Superwall secret key (`sk_4238...`) — previously committed to git

## Next Up (after Paid Apps agreement activates)
- Verify prices appear on paywall
- Test full purchase flow on TestFlight (sandbox purchase)
- Enroll in Small Business Program (15% cut)
