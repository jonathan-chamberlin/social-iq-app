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
  Models/           — Codable structs (Lesson, LessonProgress)
  Data/             — Lesson content data (Lesson1-5)
  ViewModels/       — AuthViewModel, LessonViewModel, OnboardingViewModel
  Views/
    Home/           — HomeView
    Auth/           — SignInView
    Lesson/         — LessonView + extracted subcomponents (LessonOptionCard, etc.)
    Onboarding/     — OnboardingView (coordinator) + 12 step files + enums
  Services/         — AnalyticsService, AuthService, OnboardingService, etc.
  Utilities/        — HapticService, SoundPlayer, String+Formatting
  Assets.xcassets/

## Architecture
- Pattern: MVVM with @Observable ViewModels (one per feature)
- Views: Max 100 lines. Extract subviews aggressively.
- Services: Protocol-based. Inject via init, never hardcode.
- Navigation: Type-safe Route enums, not string-based.
- Supabase: All database calls go through the service layer, never directly from ViewModels.

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
- NEVER call `Mixpanel.mainInstance().flush()` per-event. Mixpanel batches automatically.

### Error handling
- Custom error enums conforming to `LocalizedError` per service.
- Best-effort saves (onboarding, lesson progress) — catch and continue, never block the user.

### Constants and magic values
- Magic strings shared across files MUST be extracted to `AppConfig` or a constants enum.
- UserDefaults keys MUST be in `AppConfig` (e.g., `AppConfig.shouldAutoOpenLesson1Key`).
- Animation timing values MUST be in a private `enum Timing` at the top of the struct, not inline.
- URLs and entry field IDs MUST be `private static let` constants, not inline string literals.

### Shared UI patterns
- Card backgrounds: use `.cardBackground()` (defined in Theme.swift), never inline `RoundedRectangle.fill(Color.white.opacity(0.08))`.
- Gold gradient: use `Theme.goldGradient`, never inline `LinearGradient(colors: [Theme.gold, Theme.goldLight], ...)`.
- Semantic opacity: use `Theme.Opacity.disabled/.secondary/.muted/.subtle`, never inline magic opacity values (0.3, 0.5, 0.6, 0.7).
- Screen background: use `.screenBackground()`, never inline `Color.black.ignoresSafeArea()`.
- Haptics: use `HapticService.light()/.medium()/.heavy()/.success()`, never inline `UIImpactFeedbackGenerator`.
- Sentence-splitting: use `.sentenceFormatted` (String extension), never inline `.replacingOccurrences(of: ". ", with: ".\n")`.

### Onboarding-specific
- `OnboardingView.swift` is the coordinator only — state, navigation, analytics. No step UI.
- Each step's UI lives in its own file and receives only the bindings/callbacks it needs.
- Reusable patterns: `OnboardingOptionListStep` for any single-select auto-advance list.
- Scare bullet content lives as static data on `OnboardingScareStep`, not in the coordinator.

## Banned APIs (AI agents hallucinate these — use the modern replacement)
- `foregroundColor()` → `foregroundStyle()`
- `cornerRadius()` → `clipShape(.rect(cornerRadius:))`
- `GeometryReader` (for simple sizing) → `containerRelativeFrame()`
- `onChange(of:perform:)` → `onChange(of:) { oldValue, newValue in }`
- `onAppear` with async work → `.task { }`
- `Timer.publish` / Combine → `AsyncStream` or `.task` with `sleep`
- `DispatchQueue.main.asyncAfter` → `Task { try? await Task.sleep(for:) }` (no GCD in this project)

## Skill Routing
- SwiftUI views/components → swiftui-patterns, swiftui-components
- Product decisions → app-mafia-mobile
- Supabase schema/RLS → supabase-schema-rls
- TestFlight deploy → testflight-deploy
- Analytics/Mixpanel → mixpanel-taxonomy
- Paywalls/Superwall → superwall-campaigns
- App Store Connect → app-store-connect

## TestFlight Awareness
- Local changes are NOT on TestFlight until archived and uploaded — say this explicitly
- After code changes, proactively offer to archive and upload if goal is device testing
- Track temporary debug changes and revert before committing

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
- Do NOT use Combine (Timer.publish, etc.) — the project uses async/await exclusively
- Force unwraps on URL construction will be rejected — use optional binding or guard/let
- `import UIKit` should only appear in Utilities (HapticService, SoundPlayer) — views use the service wrappers
- Do NOT use `DispatchQueue.main.asyncAfter` — use `Task { try? await Task.sleep(for:) }` instead
- Do NOT import framework SDKs (SuperwallKit, Supabase) directly in Views — use service wrappers (SuperwallService, SupabaseService)
- All `print()` statements MUST be wrapped in `#if DEBUG` / `#endif` — no debug logging in release builds
- Supabase `.auth.session` reads from local Keychain cache WITHOUT server validation — use `refreshSession()` for session restore to catch deleted/invalidated users
- Apple Sign In only sends `fullName`/`email` on the VERY FIRST authorization per app+Apple ID pair — persist these to `user_profiles` immediately, never rely on `auth.users` metadata (gets overwritten on re-auth)
- NEVER use `Superwall.shared.getPresentationResult()` as a pre-check before `register()` — it consumes campaign evaluations (counts as "matched") without assigning variants, making paywalls silently fail
- Simulator vs TestFlight differ in 3 critical ways: (1) StoreKit has no real transactions on sim, (2) iOS Keychain survives app deletion on device, (3) `#if DEBUG` code is stripped from TestFlight builds — always diagnose with MCP/dashboard BEFORE deploying code changes
- When debugging "paywall not showing", check Superwall subscription status and dashboard config FIRST, before modifying code — 4 sessions were wasted changing code when the root cause was stale StoreKit state
- `SuperwallService.identify(userId:)` MUST be called after sign-in — without it, Superwall uses device identity and new accounts inherit stale subscription state from previous users
