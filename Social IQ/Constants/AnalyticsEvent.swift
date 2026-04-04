//
//  AnalyticsEvent.swift
//  Social IQ
//

import Foundation

enum AnalyticsEvent: String {
    case appOpened = "app_opened"
    case onboardingStarted = "onboarding_started"
    case onboardingStepCompleted = "onboarding_step_completed"
    case onboardingCompleted = "onboarding_completed"
    case lessonStarted = "lesson_started"
    case lessonCompleted = "lesson_completed"
    case lessonLockedTap = "lesson_locked_tap"
    case paywallPresented = "paywall_presented"
    case subscriptionStarted = "subscription_started"
}

enum SuperwallPlacement: String {
    case onboardingComplete = "onboarding_complete"
    case lessonLocked = "lessons_locked"
}
