//
//  AnalyticsService.swift
//  Social IQ
//

import Foundation
import Mixpanel

enum AnalyticsService {

    static func initialize(token: String) {
        Mixpanel.initialize(token: token, trackAutomaticEvents: false)
        #if DEBUG
        Mixpanel.mainInstance().loggingEnabled = true
        #endif
        // Claim the persistent device UUID as the Mixpanel distinct_id before any
        // event fires. When identify() is later called with the Supabase user id,
        // Mixpanel aliases the two ids natively so pre-sign-in events stay joined.
        Mixpanel.mainInstance().identify(distinctId: AppConstants.deviceUUID())
        let buildType = currentBuildType
        let isInternal = buildType != "app_store"
        let buildProps: [String: MixpanelType] = [
            "build_type": buildType,
            "is_internal": isInternal
        ]
        Mixpanel.mainInstance().registerSuperProperties(buildProps)
        Mixpanel.mainInstance().people.set(properties: buildProps)
        track(event: .appOpened)
        Mixpanel.mainInstance().flush()
    }

    private static var currentBuildType: String {
        #if DEBUG
        return "debug"
        #else
        // TestFlight builds ship with a sandbox receipt; App Store builds with a production receipt.
        if Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt" {
            return "testflight"
        }
        return "app_store"
        #endif
    }

    static func track(event: AnalyticsEvent, properties: [String: MixpanelType]? = nil) {
        Mixpanel.mainInstance().track(event: event.rawValue, properties: properties)
    }

    static func identify(userId: String) {
        Mixpanel.mainInstance().identify(distinctId: userId)
    }

    /// Clear the current user identity and re-seed the distinct_id with the
    /// persistent device UUID so a subsequent sign-in aliases cleanly instead
    /// of inheriting the prior user's events.
    static func reset() {
        Mixpanel.mainInstance().reset()
        Mixpanel.mainInstance().identify(distinctId: AppConstants.deviceUUID())
    }

    static func setUserProperties(_ properties: [String: MixpanelType]) {
        Mixpanel.mainInstance().people.set(properties: properties)
    }
}
