# Daily Log

## 2026-04-14

### Commits
- ff073fb fix: let app open offline when loading screen can't reach Supabase

### Milestones
- Build number bumped: CURRENT_PROJECT_VERSION 27 → 28 (new TestFlight build candidate)

### Files touched
6

### Notes
- Offline-tolerant app launch: AuthService, OnboardingService, Social_IQApp, AppConstants updated so the loading screen no longer blocks when Supabase is unreachable.
- pbxproj build number bump indicates a new build is ready for TestFlight upload (not yet confirmed shipped).
