---
globs: ["**/ViewModels/**/*.swift", "**/*ViewModel.swift"]
---
# ViewModel Rules

- Use `@Observable` macro, not `ObservableObject`/`@Published`.
- Mark with `@MainActor` for UI-bound state (project default: MainActor isolation).
- Inject services via init parameters with protocol types when testability matters.
- One ViewModel per feature screen. Keep focused.
- All Supabase/API calls go through service layer, never direct client calls.
- Track Mixpanel events here via `AnalyticsService.track()`, not in Views.
- No UI framework imports (`SwiftUI` view types) — ViewModels expose data, not views.
