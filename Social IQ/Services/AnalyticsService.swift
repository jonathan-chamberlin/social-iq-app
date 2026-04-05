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
        track(event: .appOpened)
        Mixpanel.mainInstance().flush()
    }

    static func track(event: AnalyticsEvent, properties: [String: MixpanelType]? = nil) {
        Mixpanel.mainInstance().track(event: event.rawValue, properties: properties)
        Mixpanel.mainInstance().flush()
    }

    static func identify(userId: String) {
        Mixpanel.mainInstance().identify(distinctId: userId)
    }

    static func setUserProperties(_ properties: [String: MixpanelType]) {
        Mixpanel.mainInstance().people.set(properties: properties)
    }
}
