//
//  AppConstants.swift
//  Social IQ
//

import Foundation

enum AppConstants {
    // MARK: - UserDefaults Keys
    static let shouldAutoOpenLesson1Key = "shouldAutoOpenLesson1"

    // MARK: - Subscription Product IDs
    static let annualProductId = "com.jonathanchamberlin.socialiq.annual"
    static let weeklyProductId = "com.jonathanchamberlin.socialiq.weekly"

    // MARK: - Lesson Social Proof
    static let lessonCompletionCounts: [String: Int] = [
        "lesson-1": 4220,
        "lesson-2": 3349,
        "lesson-3": 3873,
        "lesson-4": 3693,
        "lesson-5": 3519,
    ]

    static let lessonPercentiles: [String: Int] = [
        "lesson-1": 97,
        "lesson-2": 99,
        "lesson-3": 83,
        "lesson-4": 77,
        "lesson-5": 90,
    ]
}
