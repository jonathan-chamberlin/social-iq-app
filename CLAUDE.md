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
- **Target:** iOS 26.2+, Swift 5.0, Xcode 26.3+

## Swift/SwiftUI Conventions

- `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor` — all code is main-actor-isolated by default
- `SWIFT_APPROACHABLE_CONCURRENCY = YES` — modern concurrency syntax enabled
- Uses `#Preview` macro for SwiftUI previews
- Localization support enabled (string catalogs)

## Product Strategy Reference
This app is being built using principles from the App Mafia course. The full playbook is available as a global skill: `app-mafia-mobile`.

- When making product, design, distribution, or prioritization decisions, invoke the `app-mafia-mobile` skill
- Default to the App Mafia's approach: launch fast, iterate based on data, optimize for organic social media distribution, use AI to enable new product categories
- Project-specific design docs (ideation, design reference, competitive analysis) are in `.claude/downloads/`

## Notes

- No `.gitignore` exists yet — xcuserdata is currently tracked
- No test targets defined yet
- Automatic code signing with team ID 35373542G8
