// SUPERWALL DASHBOARD SETUP:
// 1. Create campaign "Onboarding Paywall" → placement: "onboarding_complete"
// 2. Create campaign "Lesson Locked" → placement: "lesson_locked"
// 3. Create campaign "Transaction Abandoned" → placement: "transaction_abandon" (built-in Superwall event)
// 4. For transaction_abandoned: set 50-80% discount offer (23.1% conversion, +40% revenue)
// 5. Use Superwall template paywalls until $1M+ ARR

//
//  SuperwallService.swift
//  Social IQ
//

import Foundation
import SuperwallKit

final class SuperwallService {
    static func configure() {
        Superwall.configure(apiKey: AppConfig.superwallAPIKey)
    }

    /// Present a paywall for a specific placement.
    static func presentPaywall(placement: SuperwallPlacement = .lessonLocked) {
        Superwall.shared.register(placement: placement.rawValue)
    }

    /// Present a paywall and execute `onDismiss` after the user finishes interacting.
    /// The feature block fires when:
    /// - The user purchases and the paywall closes
    /// - The user dismisses without purchasing
    /// - No paywall is configured for this placement
    static func presentPaywall(placement: SuperwallPlacement, onDismiss: @escaping @Sendable () -> Void) {
        Superwall.shared.register(placement: placement.rawValue) {
            onDismiss()
        }
    }

    static var isSubscribed: Bool {
        if case .active(_) = Superwall.shared.subscriptionStatus {
            return true
        }
        return false
    }

    // NOTE: transaction_abandon is a built-in Superwall event.
    // No code-side registration needed — configure it entirely in the Superwall dashboard
    // by creating a campaign triggered by the "transaction_abandon" event.
    // Set the offer to 50-80% discount for maximum win-back conversion.
}
