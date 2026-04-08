// SUPERWALL DASHBOARD SETUP:
// 1. Create campaign "Onboarding Paywall" → placement: "onboarding_complete"
// 2. Create campaign "Lesson Locked" → placement: "lessons_locked"
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
        AnalyticsService.track(event: .paywallPresented, properties: ["trigger": placement.rawValue])
        Superwall.shared.register(placement: placement.rawValue)
    }

    /// Present a paywall and execute `onDismiss` after the user finishes interacting,
    /// regardless of whether they purchased or dismissed.
    static func presentPaywall(placement: SuperwallPlacement, onDismiss: @escaping @Sendable () -> Void) {
        AnalyticsService.track(event: .paywallPresented, properties: ["trigger": placement.rawValue])
        let handler = PaywallPresentationHandler()
        handler.onDismiss { _, result in
            if case .purchased = result {
                AnalyticsService.track(event: .subscriptionStarted)
            }
            onDismiss()
        }
        handler.onSkip { _ in
            onDismiss()
        }
        handler.onError { _ in
            onDismiss()
        }
        Superwall.shared.register(placement: placement.rawValue, handler: handler)
    }

    /// Present a paywall and execute `onComplete` when the user should proceed.
    /// The feature block fires when the user has access (purchased, already subscribed, or no paywall configured).
    static func presentPaywallWithHandler(placement: SuperwallPlacement, onComplete: @escaping () -> Void) {
        AnalyticsService.track(event: .paywallPresented, properties: ["trigger": placement.rawValue])
        Superwall.shared.register(placement: placement.rawValue) {
            if isSubscribed {
                AnalyticsService.track(event: .subscriptionStarted)
            }
            onComplete()
        }
    }

    #if DEBUG
    static var debugForceSubscribed = false
    #endif

    static var isSubscribed: Bool {
        #if DEBUG
        if debugForceSubscribed { return true }
        #endif
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
