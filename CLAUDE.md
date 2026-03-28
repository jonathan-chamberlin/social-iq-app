# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Social IQ is a native iOS app built with SwiftUI. Currently at initial scaffold stage — no business logic, networking, or persistence yet.

## Build & Run

This is an Xcode project (no SPM command-line build). All build/run/test operations go through Xcode or `xcodebuild`:

```bash
# Build
xcodebuild -project "Social IQ.xcodeproj" -scheme "Social IQ" -sdk iphonesimulator build

# Run tests (once test targets exist)
xcodebuild -project "Social IQ.xcodeproj" -scheme "Social IQ" -sdk iphonesimulator test

# Clean
xcodebuild -project "Social IQ.xcodeproj" -scheme "Social IQ" clean
```

No third-party dependencies or package manager configured yet.

## Architecture

- **Entry point:** `Social IQ/Social_IQApp.swift` — `@main` SwiftUI App
- **UI:** `Social IQ/ContentView.swift` — root view
- **Assets:** `Social IQ/Assets.xcassets/` — app icon, accent color
- **Target:** iOS 17.0+, Swift 5.0, Xcode 26.3+

## Swift/SwiftUI Conventions

- `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor` — all code is main-actor-isolated by default
- `SWIFT_APPROACHABLE_CONCURRENCY = YES` — modern concurrency syntax enabled
- Uses `#Preview` macro for SwiftUI previews
- Localization support enabled (string catalogs)

## Product Strategy Reference
Always read `~/.claude/skills/app-mafia-mobile/SKILL.md` for the App Mafia playbook. Dive into its `references/` modules for deep context on ideation, design, development, and distribution.

Project-specific docs live in `references/` at the repo root:
- `ideation-reference.md` — problem definition, target audience, app concept
- `ideation-raw-research.md` — raw field notes from Instagram, TikTok, Reddit research
- `design-reference.md` — UX/UI decisions, onboarding flow, screen designs
- `competitive-analysis.md` — competitor landscape for social skills apps
- `tech-stack-reference.md` — decided tech stack and rationale
- `monetization-reference.md` — pricing, revenue levers, paywall strategy
- `analytics-event-taxonomy.md` — Mixpanel events, user properties, key funnels

## Notes

- No `.gitignore` exists yet — xcuserdata is currently tracked
- No test targets defined yet
- Automatic code signing with team ID 35373542G8
