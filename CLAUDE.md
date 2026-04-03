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

## Simulator
iPhone 17 Pro — UDID: F9A3AAE0-306C-412C-AA3F-491BD795870A
Launch: xcrun simctl launch F9A3AAE0-306C-412C-AA3F-491BD795870A com.jonathanchamberlin.Social-IQ
Screenshot: xcrun simctl io booted screenshot /tmp/social-iq-screen.png

## Project structure
Social IQ/
  Config/           — AppConfig (Supabase URL, API keys)
  Constants/        — DatabaseSchema, AnalyticsEvent
  Models/           — Codable structs (Lesson, UserProfile, LessonProgress)
  Data/             — Lesson content data (Lesson1-5)
  ViewModels/       — AuthViewModel, LessonViewModel, OnboardingViewModel
  Views/
    Home/           — HomeView
    Auth/           — SignInView
    Lesson/         — LessonView
    Paywall/        — PaywallView
    Onboarding/     — Onboarding flow
  Services/         — AnalyticsService, AuthService
  Utilities/
  Assets.xcassets/

## Rules
- One type per file, named after the type
- // MARK: - for section headers in every file
- After changes: build → verify compilation → run tests → screenshot
- NEVER modify .pbxproj directly
- All Supabase tables snake_case, all Swift types PascalCase
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
