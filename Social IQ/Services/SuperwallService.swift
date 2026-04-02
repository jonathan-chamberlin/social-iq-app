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

    static func presentPaywall(event: String = "campaign_trigger") {
        Superwall.shared.register(placement: event)
    }

    static var isSubscribed: Bool {
        if case .active = Superwall.shared.subscriptionStatus {
            return true
        }
        return false
    }
}
