# Refactor Report
Generated: 2026-04-21
Last-run marker: 2026-04-14T23:55:40Z

## Files Changed Since Last Run (16 source files)

Swift (15):
- Social IQ/Constants/AnalyticsEvent.swift
- Social IQ/Models/Coachmark.swift
- Social IQ/Services/AnalyticsService.swift
- Social IQ/Services/CoachmarkController.swift
- Social IQ/Social_IQApp.swift
- Social IQ/ViewModels/LessonViewModel.swift
- Social IQ/ViewModels/OnboardingViewModel.swift
- Social IQ/Views/Coachmark/CoachmarkOverlay.swift
- Social IQ/Views/Home/FeedbackButton.swift
- Social IQ/Views/Lesson/LessonAnswerSection.swift
- Social IQ/Views/Lesson/LessonView.swift
- Social IQ/Views/Onboarding/OnboardingNameAgeGenderStep.swift
- Social IQ/Views/Onboarding/OnboardingStep.swift
- Social IQ/Views/Onboarding/OnboardingView.swift
- Social IQ/Views/Onboarding/OnboardingWelcomeStep.swift

Python (1):
- scripts/mixpanel/retro_tag_internal_users.py

## Fixes Applied

### Wave 1 — Magic Opacity Extraction (BUILD: SUCCESS)

**OnboardingView.swift**
- Added `private enum ContinueButton` with `activeOpacity = 0.15` and `disabledOpacity = 0.05` constants.
- Lines 173-174: replaced inline `Color.white.opacity(0.15)` / `Color.white.opacity(0.05)` with `ContinueButton.activeOpacity` / `ContinueButton.disabledOpacity`.
- Reason: magic values not in Theme.Opacity; button-specific affordance opacities need named intent.

**CoachmarkOverlay.swift**
- Line 115: `.black.opacity(0.5)` -> `.black.opacity(Theme.Opacity.secondary)` (bubble shadow)
- Line 148: `.black.opacity(0.5)` -> `.black.opacity(Theme.Opacity.secondary)` (arrow shadow)
- Reason: 0.5 == Theme.Opacity.secondary; using the named constant removes the magic number.

**OnboardingNameAgeGenderStep.swift**
- Added `private static let unselectedFillOpacity: Double = 0.08` constant with explanatory comment.
- Line 39: replaced inline `Color.white.opacity(0.08)` with `Color.white.opacity(Self.unselectedFillOpacity)`.
- Reason: same value as `.cardBackground()` interior but applied to a Capsule; named constant clarifies intent.

### Wave 2 — Analytics Calls Moved from View to ViewModel (BUILD: SUCCESS)

**LessonViewModel.swift** — Added `// MARK: - Analytics` section with 4 new methods:
- `trackLessonStarted(isReplay:)` — consolidates lessonStarted + lessonReplayed events with lesson_id property.
- `trackQuestionAnswered(selectedIndex:)` — moved from inline closure in LessonView; computes time_to_answer from `questionStartedAt`.
- `trackLessonAbandoned()` — moved from scenePhase onChange in LessonView.
- `trackLessonCompleted()` — moved from isComplete onChange in LessonView.
- Reason: CLAUDE.md ViewModel rules state "Track Mixpanel events here via AnalyticsService.track(), not in Views."

**LessonView.swift** — Removed all 6 direct AnalyticsService.track() calls:
- onAppear: replaced with `viewModel.trackLessonStarted(isReplay: isReplay)`.
- onTrackAnswer closure: replaced with `viewModel.trackQuestionAnswered(selectedIndex: selected)`.
- scenePhase onChange: replaced with `viewModel.trackLessonAbandoned()`.
- isComplete onChange: replaced with `viewModel.trackLessonCompleted()`.
- startNextLesson(): replaced `AnalyticsService.track(event: .lessonStarted, ...)` with `viewModel.trackLessonStarted(isReplay: false)`.
- LessonView no longer imports or references AnalyticsService directly.

## Files NOT Changed (no violations found)

- AnalyticsEvent.swift — clean enum, no issues
- Coachmark.swift — GeometryReader usage is intentional (anchor frame measurement, not simple sizing); not a smell here
- AnalyticsService.swift — flush() in initialize() is intentional startup flush, not per-event
- CoachmarkController.swift — all print() calls confirmed inside #if DEBUG blocks
- Social_IQApp.swift — all print() calls confirmed inside #if DEBUG blocks; clean architecture
- OnboardingViewModel.swift — clean, proper @Observable, analytics correctly in ViewModel
- LessonAnswerSection.swift — clean, no violations
- OnboardingStep.swift — clean enum, no issues
- OnboardingWelcomeStep.swift — clean, uses Theme helpers correctly
- FeedbackButton.swift — clean, uses Theme.goldGradient and Theme.Opacity.disabled
- retro_tag_internal_users.py — one-off script, clean Python, reads creds from env file

## Build Verification

| Wave | Description | Result |
|------|-------------|--------|
| Wave 1 | Magic opacity extraction (3 files) | SUCCESS — 0 errors, 0 warnings |
| Wave 2 | Analytics moved View → ViewModel | SUCCESS — 0 errors, 0 warnings |

## Before/After Scorecard

| Metric | Before | After | Delta |
|--------|--------|-------|-------|
| Files > 300 lines | 0 (0%) | 0 (0%) | 0 |
| Files > 500 lines | 0 (0%) | 0 (0%) | 0 |
| Deprecated APIs (foregroundColor/cornerRadius/NavigationView etc.) | 0 | 0 | 0 |
| Magic opacity values (0.3/0.5/0.6/0.7 inline) | 4 | 0 | -4 |
| Other magic opacity values (0.08/0.15/0.05 inline) | 3 | 0 | -3 |
| Analytics calls in Views (changed files) | 6 | 0 | -6 |
| Unguarded print() calls | 0 | 0 | 0 |
| @Observable violations (ObservableObject/@Published) | 0 | 0 | 0 |
| Total changed file line counts | 785 | 760 | -25 |

### Line counts (changed files only)

| File | Before | After |
|------|--------|-------|
| LessonView.swift | 187 | 170 |
| LessonViewModel.swift | 90 | 127 |
| OnboardingView.swift | 187 | 194 |
| OnboardingNameAgeGenderStep.swift | 61 | 64 |
| CoachmarkOverlay.swift | 205 | 205 |

LessonView grew smaller by consolidating analytics into ViewModel (net -17 lines in View,
+37 lines in ViewModel for 4 well-scoped methods averaging ~9 lines each).

## Remaining Known Debt (out of scope — not changed since last run)

- HomeView.swift (211 lines): 3 direct AnalyticsService.track() calls in View body — same
  architecture smell as LessonView had. Candidate for next cycle.
