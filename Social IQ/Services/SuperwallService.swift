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
        // Claim a stable per-install UUID as the Superwall user id BEFORE any
        // paywall can fire. Without this, transactions that happen before
        // post-sign-in identify() get tagged under Superwall's anonymous
        // `$SuperwallAlias:*` id and never surface under the real user.
        Superwall.shared.identify(userId: AppConstants.deviceUUID())
    }

    /// Associate Superwall with a specific user so subscription state is per-user, not per-device.
    /// Must be called after sign-in so a new account on the same device starts fresh.
    /// Superwall aliases the prior id to the new id for paywall assignments going forward;
    /// historical events stay attached to the prior id.
    static func identify(userId: String) {
        Superwall.shared.identify(userId: userId)
    }

    /// Attach key/value attributes to the current Superwall user. These ride along
    /// in every webhook payload, so the server-side subscription table can always
    /// cross-reference supabase_user_id ↔ device_user_id.
    static func setUserAttributes(_ attributes: [String: Any]) {
        Superwall.shared.setUserAttributes(attributes)
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
            } else {
                AnalyticsService.track(event: .paywallDismissed, properties: ["trigger": placement.rawValue])
            }
            onDismiss()
        }
        // Don't call onDismiss on skip — if no paywall is configured,
        // the user should stay on the current screen, not silently advance.
        handler.onError { _ in
            onDismiss()
        }
        Superwall.shared.register(placement: placement.rawValue, handler: handler)
    }

    /// Present a paywall with handler callbacks and a feature block fallback.
    /// The feature block fires when no paywall is shown (user subscribed, holdout, etc.).
    static func presentPaywallWithHandler(placement: SuperwallPlacement, onComplete: @escaping @Sendable () -> Void) {
        #if DEBUG
        print("[Superwall] presentPaywallWithHandler called for placement: \(placement.rawValue)")
        print("[Superwall] subscriptionStatus: \(Superwall.shared.subscriptionStatus)")
        #endif
        AnalyticsService.track(event: .paywallPresented, properties: ["trigger": placement.rawValue])

        let handler = PaywallPresentationHandler()
        handler.onDismiss { _, result in
            #if DEBUG
            print("[Superwall] onDismiss fired, result: \(result)")
            #endif
            if case .purchased = result {
                AnalyticsService.track(event: .subscriptionStarted)
            } else {
                AnalyticsService.track(event: .paywallDismissed, properties: ["trigger": placement.rawValue])
            }
            Task { @MainActor in onComplete() }
        }
        handler.onSkip { reason in
            #if DEBUG
            print("[Superwall] onSkip fired, reason: \(reason)")
            #endif
            Task { @MainActor in onComplete() }
        }
        handler.onError { error in
            #if DEBUG
            print("[Superwall] onError fired: \(error)")
            #endif
            Task { @MainActor in onComplete() }
        }
        Superwall.shared.register(placement: placement.rawValue, handler: handler) {
            #if DEBUG
            print("[Superwall] feature block fired (user has access or no paywall)")
            #endif
            Task { @MainActor in onComplete() }
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

    static func restorePurchases() async throws {
        let restorationResult = try await Superwall.shared.restorePurchases()
        // restorationResult indicates whether restoration found active entitlements
        // The subscription status updates automatically via Superwall's observer
    }

    static func reset() {
        Superwall.shared.reset()
        // Re-claim the persistent device UUID so post-sign-out events/paywalls
        // still attribute to an id we control, not a fresh Superwall alias.
        Superwall.shared.identify(userId: AppConstants.deviceUUID())
    }

    // NOTE: transaction_abandon is a built-in Superwall event.
    // No code-side registration needed — configure it entirely in the Superwall dashboard
    // by creating a campaign triggered by the "transaction_abandon" event.
    // Set the offer to 50-80% discount for maximum win-back conversion.
}
