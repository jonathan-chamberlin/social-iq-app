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

    static func setUserProperties(_ properties: [String: MixpanelType]) {
        Mixpanel.mainInstance().people.set(properties: properties)
    }
}
