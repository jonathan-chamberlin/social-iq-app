---
name: swiftui-components
description: SwiftUI component patterns for Social IQ — @Observable, NavigationStack, consumer app patterns. Trigger on: "new view", "component", "swiftui", "navigation", "view model".
---

# SwiftUI Components for Social IQ

## State management
- Use @Observable macro for ALL view models (never ObservableObject)
- Use @State for view-local state
- Use @Environment for dependency injection
- Never use @Published, @StateObject, or @ObservedObject

```swift
@Observable
final class LessonViewModel {
  var lessons: [Lesson] = []
  var isLoading = false
  var error: Error?

  func fetchLessons() async {
    isLoading = true
    defer { isLoading = false }
    do {
      lessons = try await SupabaseService.shared.fetchLessons()
    } catch {
      self.error = error
    }
  }
}
```

## Navigation
- NavigationStack ONLY (never NavigationView)
- Use NavigationPath for programmatic navigation
- Use .navigationDestination(for:) with value-type routing

```swift
@Observable
final class Router {
  var path = NavigationPath()

  func navigate(to destination: AppDestination) {
    path.append(destination)
  }

  func popToRoot() {
    path = NavigationPath()
  }
}

enum AppDestination: Hashable {
  case lesson(Lesson)
  case profile
  case settings
  case achievement(Achievement)
}
```

## View structure
```swift
struct LessonView: View {
  let lesson: Lesson
  @State private var viewModel = LessonViewModel()

  var body: some View {
    content
      .task { await viewModel.load(lesson) }
  }

  private var content: some View {
    // Extract body into computed properties for readability
  }
}
```

## File organization
- One type per file, named after the type
- Views/{Feature}/FeatureView.swift
- ViewModels/FeatureViewModel.swift
- Models/ModelName.swift
- Services/ServiceName.swift

## Concurrency
- MainActor isolation is the default (SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor)
- Use .task { } for async work in views (auto-cancelled on disappear)
- Use @concurrent for explicit background work
- Never use DispatchQueue, never use Combine

## Common patterns
- Loading states: enum ViewState<T> { case idle, loading, loaded(T), error(Error) }
- Pull to refresh: .refreshable { await viewModel.refresh() }
- Pagination: .onAppear of last item triggers loadMore()
- #Preview macro for all views

## Post-task reflection (run after every completed task)

Before marking the Notion task Done, answer these four questions:
1. Did I do anything differently from what this skill instructed?
2. Did I encounter an error this skill didn't anticipate?
3. Did I find a faster or better method?
4. Did the human override my approach at any decision point?

If YES to any: format a skill update proposal:
  SKILL UPDATE PROPOSED — swiftui-components
  Change: [what to add/modify/remove]
  Reason: [why this would have helped]
  Diff: [exact before/after lines]

Send via ccgram as a decision card (same format as Layer 1).
Wait for approval before modifying the skill file.
If approved: apply the diff. Commit: "skill: swiftui-components update — [one-line reason] [agent]"
If rejected: log the reasoning in DECISIONS.md and do not retry.
