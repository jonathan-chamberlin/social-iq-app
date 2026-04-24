//
//  AppConstants.swift
//  Social IQ
//

import Foundation

enum AppConstants {
    // MARK: - UserDefaults Keys
    static let shouldAutoOpenLesson1Key = "shouldAutoOpenLesson1"
    /// Cached onboarding-completed flag keyed by user id. Used as an offline
    /// fallback when the Supabase profile fetch can't reach the server.
    static let onboardingCompletedCachePrefix = "onboardingCompleted."
    /// Persistent per-install UUID used as the Superwall/Mixpanel identity from
    /// the instant the app launches — before sign-in. Prevents purchases from
    /// being tagged under Superwall's anonymous alias id.
    static let deviceUUIDKey = "device_user_id"

    // MARK: - Device Identity

    /// Returns a stable UUID string for this install. Generates + persists on first
    /// call, then returns the cached value on every subsequent call (including
    /// across launches). UUID format is required by StoreKit 2 `appAccountToken`.
    static func deviceUUID() -> String {
        if let cached = UserDefaults.standard.string(forKey: deviceUUIDKey),
           UUID(uuidString: cached) != nil {
            return cached
        }
        let fresh = UUID().uuidString
        UserDefaults.standard.set(fresh, forKey: deviceUUIDKey)
        return fresh
    }

    // MARK: - Free Lessons
    static let freeLessonIds: Set<String> = ["lesson-3", "lesson-2", "lesson-4", "lesson-7"]

    // MARK: - Subscription Product IDs
    static let annualProductId = "com.jonathanchamberlin.socialiq.annual"
    static let weeklyProductId = "com.jonathanchamberlin.socialiq.weekly"

    // MARK: - External Links
    static let privacyPolicyURL = URL(string: "https://jonathan-chamberlin.github.io/social-iq-app/privacy-policy")!
    static let termsOfUseURL = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!
    static let supportURL = URL(string: "https://jonathan-chamberlin.github.io/social-iq-app/support")!
}
