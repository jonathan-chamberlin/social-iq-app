# Phase 2: Supabase Auth + Superwall — Implementation Notes

## What was done

1. **SupabaseService** — Singleton wrapping `SupabaseClient`, initialized with AppConfig credentials
2. **AuthService** — Sign in with Apple flow using nonce + SHA256, exchanges Apple credential for Supabase session via `signInWithIdToken`, session restore on launch, sign out
3. **AuthViewModel** — `@Observable` with `AuthState` enum carrying the Supabase `User`, error handling, session restoration
4. **SignInView** — Dark background, `SignInWithAppleButton` wired to AuthService nonce flow, loading/error states
5. **SuperwallService** — Static `configure()` and `presentPaywall(event:)` wrappers around SuperwallKit
6. **HomeView** — Shows user name from Supabase metadata, Start Lesson nav link, Upgrade button triggering Superwall, Sign Out
7. **Social_IQApp** — Initializes Supabase + Superwall on launch, routes by auth state, restores session via `.task`

## Architecture decisions

- **SignInWithAppleButton + AuthService nonce flow**: The SwiftUI `SignInWithAppleButton` handles the Apple UI and credential retrieval. AuthService generates the nonce (stored internally) and its SHA256 hash is set on the request. On completion, the credential is passed to AuthService which exchanges it with Supabase. This avoids a manual `ASAuthorizationController` delegate.
- **AuthState carries User**: `AuthState.signedIn(User)` embeds the Supabase `User` directly rather than using a separate `currentUser` property. Single source of truth.
- **SuperwallService as enum**: No instances needed — purely static methods. Matches the singleton nature of `Superwall.shared`.
- **UserProfile model unused for now**: The existing `UserProfile` model isn't used in Phase 2. Auth uses Supabase's `User` type directly. UserProfile will matter when we store app-specific profile data in Supabase tables.

## Before you build in Xcode

1. Add SPM packages:
   - `supabase-swift` (https://github.com/supabase/supabase-swift)
   - `SuperwallKit` (https://github.com/superwall/Superwall-iOS)
2. Enable "Sign in with Apple" capability in the target's Signing & Capabilities
3. The `User.userMetadata` access pattern in HomeView uses `AnyJSON` pattern matching — if the Supabase SDK version uses a different JSON type, adjust the `userName` computed property

## Potential compile issues

- **`AnyJSON` pattern matching**: The `case .string(let name) = metadata` pattern in HomeView depends on the exact `AnyJSON` enum definition in your version of supabase-swift. May need `metadata.stringValue` or `metadata.value as? String` instead.
- **`Superwall.shared.subscriptionStatus == .active`**: Check if your SuperwallKit version uses this exact comparison or a different pattern (e.g., `if case .active = status`).
