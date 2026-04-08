---
globs: ["**/*Tests*/**/*.swift", "**/*Test.swift", "**/*Spec.swift"]
---
# Testing Rules

- Name tests: `test_methodName_scenario_expectedResult`
- Use Swift Testing framework (`@Test`, `#expect`) if available, XCTest otherwise.
- Mock services using protocol conformance, not subclassing.
- Each ViewModel should have a corresponding test file.
- Test files mirror source structure: `Social IQTests/ViewModels/AuthViewModelTests.swift`
