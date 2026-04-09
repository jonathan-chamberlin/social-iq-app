---
globs: ["**/Services/**/*.swift"]
---
# Service Layer Rules

- Services are structs with static methods or `.shared` singletons (current pattern).
- Async/await only — no completion handlers, no Combine.
- Error handling: throw typed error enums conforming to `LocalizedError`.
- No `import SwiftUI` or `import UIKit` in service files.
- Functions with 5+ parameters must use a data struct instead (e.g., `OnboardingData`).
- All analytics tracking goes through `AnalyticsService.track(event:properties:)`.
- NEVER call `Mixpanel.mainInstance().flush()` per-event — Mixpanel batches automatically.
- After sign-in, call BOTH `AnalyticsService.identify()` AND `SuperwallService.identify()` — Superwall needs user-level identity to avoid stale device state.
- NEVER use `Superwall.shared.getPresentationResult()` before `register()` — it consumes campaign evaluations without assigning variants.
