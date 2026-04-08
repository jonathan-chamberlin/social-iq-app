---
globs: ["**/Views/**/*.swift", "**/*View.swift"]
---
# SwiftUI View Rules

- Max 100 lines per view file. If approaching this, extract subviews into separate files.
- Use @Observable ViewModels, never ObservableObject/@Published.
- No business logic in views — delegate to ViewModel.
- Use `.task { }` for async work, not `.onAppear` with `Task { }`.
- Use closures for actions (onSelect, onComplete), @Binding for parent state mutation.

## Banned APIs (use the modern replacement)
- `foregroundColor()` → `foregroundStyle()`
- `cornerRadius()` → `clipShape(.rect(cornerRadius:))`
- `NavigationView` → `NavigationStack`
- `GeometryReader` (for simple sizing) → `containerRelativeFrame()`
- `onChange(of:perform:)` → `onChange(of:) { oldValue, newValue in }`
- `onAppear` + async work → `.task { }`

## Shared UI Patterns
- Card backgrounds: `.cardBackground()` (Theme.swift)
- Gold gradient: `Theme.goldGradient`
- Screen background: `.screenBackground()`
- Haptics: `HapticService.light()/.medium()/.heavy()/.success()`
