# Left Off

**Last updated:** 2026-04-04

Delivery style: one phase at a time, click-by-click, grouped under headings. Don't show next phase until current is confirmed.

## Completed Today
- TestFlight: Build 3 (v1.0) uploaded and available
- Superwall: Created "Social IQ Pro" paywall (ID 203822) from Sharpen template with annual ($29.99) + weekly ($4.99)
- Superwall: Swapped both "Onboarding Paywall" and "Lesson Locked" campaigns to Social IQ Pro (100% treatment)

## Currently Active: Phase 2 — Verify Apple Sign In + Supabase Persistence (ship-blocker)

- Test A: Fresh sign-in → complete onboarding → verify row in `user_profiles` with all fields populated
- Test B: Delete app → reinstall from TestFlight → sign in again → should skip onboarding, land on HomeView
- Verify only one row exists in Supabase with same UUID, all data intact

## Phase 3: Verify Mixpanel Events

- Open Mixpanel dashboard → Events/Live View
- Trigger each event on phone: app_opened, onboarding_started, onboarding_step_completed (per step), onboarding_completed, lesson_locked_tap, lesson_started, lesson_completed
- Confirm user identity (Supabase UUID as distinct ID) appears in Mixpanel Users

## Phase 4: Confirm Payment Pipeline

- App Store Connect → Agreements, Tax, and Banking → Paid Apps agreement must be active (bank + tax + contact all green)
- Enroll in Small Business Program (15% cut) at developer.apple.com/programs/small-business-program

## Other Unfinished
- `transaction_abandon` campaign has no placement and only a holdout variant — needs paywall + placement configured
- Rotate Superwall secret key (`sk_4238...`) — previously committed to git
- Superwall MCP `create_paywall` products param and `get_paywall`/`list_paywalls` have bugs (product type mismatch)
- Old Blinkist paywall (ID 195192) and Example Paywall (ID 195191) can be archived

## Blockers
- None
