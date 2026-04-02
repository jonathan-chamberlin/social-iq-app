//
//  AnalyticsService.swift
//  Social IQ
//

import Foundation
import Mixpanel

// KEY EVENTS:
// "onboarding_started" — user enters onboarding
// "onboarding_step_completed" — properties: step_name, step_number
// "onboarding_completed" — properties: selected_goals, age, quiz_answers
// "lesson_started" — properties: lesson_id, lesson_title
// "lesson_completed" — properties: lesson_id, score, time_spent_seconds
// "lesson_locked_tap" — user tapped a locked lesson
// "paywall_presented" — properties: placement
// "subscription_started" — user subscribed

enum AnalyticsService {

    static func initialize(token: String) {
        Mixpanel.initialize(token: token, trackAutomaticEvents: true)
    }

    static func track(event: String, properties: [String: MixpanelType]? = nil) {
        Mixpanel.mainInstance().track(event: event, properties: properties)
    }

    static func identify(userId: String) {
        Mixpanel.mainInstance().identify(distinctId: userId)
    }

    static func setUserProperties(_ properties: [String: MixpanelType]) {
        Mixpanel.mainInstance().people.set(properties: properties)
    }
}
