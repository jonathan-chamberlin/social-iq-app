# Leftoff Phase Artifact

**Status:** PASS (no-op; file already reflects merged state)

## Carried forward (14)
From existing `leftoff.md`:

**Unfinished (7)**
- App Store Review resubmitted (Build 28) — waiting for Apple's response
- `SuperwallService.identify(userId:)` added but not yet tested on TestFlight
- Small Business Program enrollment submitted, waiting for confirmation email
- `transaction_abandon` campaign has no placement, only holdout variant
- Views over 100 lines not yet split: SettingsView (171), HomeView (207), LessonView (138), LessonCompletionView (129)
- 0 test files exist - 10 testable types need test coverage
- Offline loading path — implemented timeouts + cached fallback; needs real-device TestFlight verification (enable airplane mode after a prior sign-in and relaunch)

**Next Up (6)**
- Wait for Apple review response
- Once approved: create Bitly attribution links per channel
- Lesson UX: sticky "See why" button — pin to bottom of screen after correct answer
- Reddit Seeding Launch — Notion task `33dafe0d-cf03-8108-9c31-d3cdfea75a23`
- AI UGC Tool Test — Notion task `33dafe0d-cf03-8162-826b-ddced947353e`
- Add unit tests for ViewModels and Services

**Blockers (1)**
- App Store approval pending Apple review

## Newly appended (0)
No new unfinished items detected this session. Today's commits:
- `ff073fb` — offline loading fix (the unfinished real-device verification is already in the list from the prior session entry)
- `9fc7a45` — Reddit seeding doc (Reddit launch already tracked)

Untracked dirs (`paywalls/`, `submission-reqs/`) contain reference assets (paywall PNGs, App Review PDFs), not follow-ups.

## Removed as completed (0)
No items had commit sha evidence of completion. Per "when in doubt keep it", removed nothing.

## Diff
No changes to `leftoff.md` required — file already reflects the merged state. Header date `2026-04-14` already current.
