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
    case questionAnswered = "question_answered"
    case onboardingAbandoned = "onboarding_abandoned"
    case lessonAbandoned = "lesson_abandoned"
    case lessonReplayed = "lesson_replayed"
    case paywallPresented = "paywall_presented"
    case paywallDismissed = "paywall_dismissed"
    case subscriptionStarted = "subscription_started"
    case coachmarkShown = "coachmark_shown"
    case coachmarkDismissed = "coachmark_dismissed"
    case lessonWriteSkipped = "lesson_write_skipped"
}

enum SuperwallPlacement: String {
    case onboardingComplete = "onboarding_complete"
    case lessonLocked = "lessons_locked"
}
