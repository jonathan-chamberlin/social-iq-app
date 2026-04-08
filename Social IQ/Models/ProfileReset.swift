//
//  ProfileReset.swift
//  Social IQ

import Foundation

struct ProfileReset: Encodable {
    let onboardingCompleted: Bool
    let firstName: String?
    let age: Int?
    let gender: String?
    let socialContext: String?
    let quiz1Answer: String?
    let quiz2Answer: String?
    let quiz3Answer: String?
    let selectedGoals: [String]?
    let referralCode: String?
    let discoverySource: String?
    let currentStreak: Int
    let longestStreak: Int
    let totalXp: Int

    enum CodingKeys: String, CodingKey {
        case onboardingCompleted = "onboarding_completed"
        case firstName = "first_name"
        case age, gender
        case socialContext = "social_context"
        case quiz1Answer = "quiz1_answer"
        case quiz2Answer = "quiz2_answer"
        case quiz3Answer = "quiz3_answer"
        case selectedGoals = "selected_goals"
        case referralCode = "referral_code"
        case discoverySource = "discovery_source"
        case currentStreak = "current_streak"
        case longestStreak = "longest_streak"
        case totalXp = "total_xp"
    }
}
