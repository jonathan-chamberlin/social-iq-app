# Refactor Phase Artifact

**Status:** PASS (0 edits; scan clean)
**Window:** last 7 days (no last-run marker)
**Files in scope:** 49 changed `.swift` files
**Edits applied:** 0
**Build verification:** skipped — zero edits, nothing to verify

## Findings table

| Category | Hits | Action |
|---|---|---|
| Banned APIs (`foregroundColor`, `cornerRadius()`, `NavigationView`, `ObservableObject`, `@Published`, `onChange(of:perform:)`, `Timer.publish`, `import Combine`, `DispatchQueue.main.asyncAfter`) | 0 | none |
| Files > 400 lines (hard cap) | 0 | none |
| Files > 300 lines | 0 | none |
| Views > 100 lines (soft cap) | 6 | flagged |
| Inline `Color.black.ignoresSafeArea()` outside Theme.swift | 0 | none |
| Inline `RoundedRectangle.fill(Color.white.opacity(0.08))` outside Theme.swift | 0 | none |
| Inline gold `LinearGradient` | 0 | none |
| `UIImpactFeedbackGenerator` outside `Utilities/` | 0 | none |
| `print(` outside `#if DEBUG` | 0 | all 18 print sites `#if DEBUG`-wrapped |
| Magic opacity `0.3/0.5/0.6/0.7` | 0 | none |
| Direct `Superwall.shared` / `Mixpanel.mainInstance` / `supabaseClient.from` in Views or ViewModels | 0 | none |
| `import SwiftUI` / `import UIKit` in Services or ViewModels | 0 | none |
| Force-unwrapped `URL(string:)` | 3 | flagged |
| Hardcoded secrets | 0 | none |

## Flagged (not edited)

**Views over 100-line soft cap (no hard-cap violations):**
- `Social IQ/Views/Home/HomeView.swift` — 211
- `Social IQ/Views/Onboarding/OnboardingView.swift` — 184 (coordinator — expected)
- `Social IQ/Views/Home/SettingsView.swift` — 170
- `Social IQ/Views/Lesson/LessonView.swift` — 138
- `Social IQ/Views/Lesson/LessonCompletionView.swift` — 129
- `Social IQ/Views/Lesson/ResearchFrameworksSheet.swift` — 103

**Force-unwrapped URL constants** in `Social IQ/Constants/AppConstants.swift:23-25` (`privacyPolicyURL`, `termsOfUseURL`, `supportURL`). Compile-time-safe static literals; leaving for a later dedicated pass since removing the bang requires a helper + call-site changes.

## Before/After scorecard
Zero edits → before == after.

| Metric | Count |
|---|---|
| Files > 300 lines | 0 |
| Files > 400 lines | 0 |
| Deprecated API hits | 0 |
| Magic-value hits | 0 |
| Banned patterns in Views/VMs | 0 |

## Conclusion
0 actionable findings. 49 Swift files touched in the last 7 days are fully compliant. Long views and URL force-unwraps are known stylistic cleanup items already tracked in `leftoff.md`.

## Sandbox note
Subagent was denied `mkdir` and `Write` on `.claude/improve-artifacts/`. This artifact written directly by dispatcher from the subagent's inline report.
