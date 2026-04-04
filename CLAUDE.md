# Social IQ — iOS App

## Stack
- SwiftUI (iOS 17+), Swift 5.0+
- @Observable ONLY (never ObservableObject, never @Published)
- Supabase (auth + DB) — see .claude/skills/supabase-schema-rls/
- Superwall (paywalls) — see .claude/skills/superwall-campaigns/
- Mixpanel (analytics) — see .claude/skills/mixpanel-taxonomy/
- NavigationStack (never NavigationView)
- async/await (never Combine, never GCD)
- Apple Sign In via AuthenticationServices

## Concurrency
- SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor — all code is main-actor-isolated by default
- SWIFT_APPROACHABLE_CONCURRENCY = YES — modern concurrency syntax enabled
- Use @concurrent for explicit background offloading

## Build command
xcodebuild -project "Social IQ.xcodeproj" -scheme "Social IQ" \
  -destination "platform=iphonesimulator,id=F9A3AAE0-306C-412C-AA3F-491BD795870A" \
  -derivedDataPath DerivedData build 2>&1 | xcsift -w

## Physical Device
Jonathan iPhone 16 Pro — UDID: 00008140-000C11D00163001C (Platform: iOS)

## Simulator
iPhone 17 Pro — UDID: F9A3AAE0-306C-412C-AA3F-491BD795870A
Launch: xcrun simctl launch F9A3AAE0-306C-412C-AA3F-491BD795870A com.jonathanchamberlin.Social-IQ
Screenshot: xcrun simctl io booted screenshot /tmp/social-iq-screen.png

## Project structure
Social IQ/
  Config/           — AppConfig (Supabase URL, API keys, UserDefaults keys)
  Constants/        — DatabaseSchema, AnalyticsEvent
  Models/           — Codable structs (Lesson, UserProfile, LessonProgress)
  Data/             — Lesson content data (Lesson1-5)
  ViewModels/       — AuthViewModel, LessonViewModel
  Views/
    Home/           — HomeView
    Auth/           — SignInView
    Lesson/         — LessonView + extracted subcomponents (LessonOptionCard, etc.)
    Paywall/        — PaywallView
    Onboarding/     — OnboardingView (coordinator) + 12 step files + enums
  Services/         — AnalyticsService, AuthService, OnboardingService, etc.
  Utilities/
  Assets.xcassets/

## Coding Conventions

### File organization
- One type per file, named after the type. Private helper structs in the same file are acceptable.
- Files MUST stay under 400 lines. If a view exceeds this, split into coordinator + subcomponents.
- `// MARK: -` section headers in every file with 3+ sections.
- Views organized by feature folder (Home/, Lesson/, Onboarding/), not by type.

### Naming
- Swift types: PascalCase. Supabase columns: snake_case.
- Analytics event names: snake_case (`onboarding_step_completed`).
- Onboarding step files: `Onboarding<StepName>Step.swift`.
- Enums for fixed option sets (OnboardingStep, QuizSubStep, AnalyticsEvent).

### State management
- Views own `@State` for UI state. No separate ViewModel unless the view has async data loading.
- Multi-step flows use an enum-based step system (see `OnboardingStep`). NEVER use integer step tracking.
- To add/remove a step: add/remove one enum case + one step view file. Navigation, analytics, and progress dots adapt automatically.
- Bindings (`@Binding`) for child views that mutate parent state. Closures for actions (onSelect, onComplete).

### Services
- Services are structs (not classes) accessed via `SupabaseService.shared` or instantiated directly.
- Service functions that take user input MUST use a data struct (e.g., `OnboardingData`) instead of 5+ parameters.
- All analytics tracking goes through `AnalyticsService.track(event:properties:)`.

### Error handling
- Custom error enums conforming to `LocalizedError` per service.
- Best-effort saves (onboarding, lesson progress) — catch and continue, never block the user.

### Constants
- Magic strings shared across files MUST be extracted to `AppConfig` or a constants enum.
- UserDefaults keys MUST be in `AppConfig` (e.g., `AppConfig.shouldAutoOpenLesson1Key`).

### Onboarding-specific
- `OnboardingView.swift` is the coordinator only — state, navigation, analytics. No step UI.
- Each step's UI lives in its own file and receives only the bindings/callbacks it needs.
- Reusable patterns: `OnboardingOptionListStep` for any single-select auto-advance list.
- Scare bullet content lives as static data on `OnboardingScareStep`, not in the coordinator.

## Rules
- After changes: build → verify compilation → run tests → screenshot
- NEVER modify .pbxproj directly
- Team signing ID: 35373542G8

## Product Strategy Reference
Always read `~/.claude/skills/app-mafia-mobile/SKILL.md` for the App Mafia playbook.

Project-specific docs live in `references/` at the repo root:
- `ideation-reference.md` — problem definition, target audience, app concept
- `design-reference.md` — UX/UI decisions, onboarding flow, screen designs
- `competitive-analysis.md` — competitor landscape
- `tech-stack-reference.md` — tech stack and rationale
- `monetization-reference.md` — pricing, revenue levers, paywall strategy
- `analytics-event-taxonomy.md` — Mixpanel events, user properties, key funnels
- `founder-advice-foundation-hacks.md` — validated founder feedback on ICP, retention, product direction

## Gotchas (append new mistakes here)
- Xcode project has a space in it: "Social IQ.xcodeproj" — always quote paths
