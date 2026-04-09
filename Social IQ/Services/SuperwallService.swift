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

    /// Uses getPresentationResult first to diagnose what Superwall will do, then
    /// only calls register if a paywall will actually present.
    static func presentPaywallWithHandler(placement: SuperwallPlacement, onComplete: @escaping @Sendable () -> Void) {
        #if DEBUG
        print("[Superwall] presentPaywallWithHandler called for placement: \(placement.rawValue)")
        print("[Superwall] subscriptionStatus: \(Superwall.shared.subscriptionStatus)")
        #endif
        AnalyticsService.track(event: .paywallPresented, properties: ["trigger": placement.rawValue])

        Task {
            let result = await Superwall.shared.getPresentationResult(forPlacement: placement.rawValue)
            #if DEBUG
            print("[Superwall] getPresentationResult: \(result)")
            #endif

            switch result {
            case .paywall:
                // A paywall will show - use register with handler to track lifecycle
                await MainActor.run {
                    presentPaywallViaRegister(placement: placement, onComplete: onComplete)
                }
            case .placementNotFound:
                #if DEBUG
                print("[Superwall] SKIP: placement '\(placement.rawValue)' not found in any campaign")
                #endif
                await MainActor.run { onComplete() }
            case .noAudienceMatch:
                #if DEBUG
                print("[Superwall] SKIP: no audience matched for this user")
                #endif
                await MainActor.run { onComplete() }
            case .holdout(let experiment):
                #if DEBUG
                print("[Superwall] SKIP: user in holdout group for experiment \(experiment.id)")
                #endif
                await MainActor.run { onComplete() }
            case .paywallNotAvailable:
                #if DEBUG
                print("[Superwall] SKIP: paywall not available (no window, network error, etc.)")
                #endif
                await MainActor.run { onComplete() }
            @unknown default:
                #if DEBUG
                print("[Superwall] SKIP: unknown presentation result")
                #endif
                await MainActor.run { onComplete() }
            }
        }
    }

    /// Internal: present via register when we know a paywall will show.
    private static func presentPaywallViaRegister(placement: SuperwallPlacement, onComplete: @escaping @Sendable () -> Void) {
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
    }

    // NOTE: transaction_abandon is a built-in Superwall event.
    // No code-side registration needed — configure it entirely in the Superwall dashboard
    // by creating a campaign triggered by the "transaction_abandon" event.
    // Set the offer to 50-80% discount for maximum win-back conversion.
}
