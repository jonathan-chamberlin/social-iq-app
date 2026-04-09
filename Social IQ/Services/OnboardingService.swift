//
//  OnboardingService.swift
//  Social IQ
//

import Foundation
import Supabase

struct OnboardingData {
    let firstName: String
    let age: Int
    let gender: String?
    let socialContext: String?
    let quiz1Answer: String?
    let quiz2Answer: String?
    let quiz3Answer: String?
    let selectedGoals: [String]
    let referralCode: String?
    let discoverySource: String?
}

enum OnboardingError: LocalizedError {
    case profileNotFound(String)
    case saveFailed(String)

    var errorDescription: String? {
        switch self {
        case .profileNotFound(let userId):
            "No profile found for user \(userId)"
        case .saveFailed(let reason):
            "Failed to save onboarding data: \(reason)"
        }
    }
}

struct OnboardingService {
    private var client: SupabaseClient {
        SupabaseService.shared.client
    }

    func fetchOnboardingCompleted(userId: String) async throws -> Bool {
        struct ProfileRow: Decodable {
            let onboardingCompleted: Bool

            enum CodingKeys: String, CodingKey {
                case onboardingCompleted = "onboarding_completed"
            }
        }

        let rows: [ProfileRow] = try await client
            .from(DatabaseSchema.UserProfiles.table)
            .select(DatabaseSchema.UserProfiles.onboardingCompleted)
            .eq(DatabaseSchema.UserProfiles.id, value: userId)
            .execute()
            .value

        return rows.first?.onboardingCompleted ?? false
    }

    func resetProfile(userId: String) async throws {
        let reset = ProfileReset(
            onboardingCompleted: false,
            age: nil, gender: nil, socialContext: nil,
            quiz1Answer: nil, quiz2Answer: nil, quiz3Answer: nil,
            selectedGoals: nil, referralCode: nil, discoverySource: nil,
            currentStreak: 0, longestStreak: 0, totalXp: 0
        )

        try await client
            .from(DatabaseSchema.UserProfiles.table)
            .update(reset)
            .eq(DatabaseSchema.UserProfiles.id, value: userId)
            .execute()
    }

    func completeOnboarding(userId: String, data: OnboardingData) async throws {
        struct ProfileUpdate: Encodable {
            let onboardingCompleted: Bool
            let firstName: String
            let age: Int
            let gender: String?
            let socialContext: String?
            let quiz1Answer: String?
            let quiz2Answer: String?
            let quiz3Answer: String?
            let selectedGoals: [String]
            let referralCode: String?
            let discoverySource: String?

            enum CodingKeys: String, CodingKey {
                case onboardingCompleted = "onboarding_completed"
                case firstName = "first_name"
                case age
                case gender
                case socialContext = "social_context"
                case quiz1Answer = "quiz1_answer"
                case quiz2Answer = "quiz2_answer"
                case quiz3Answer = "quiz3_answer"
                case selectedGoals = "selected_goals"
                case referralCode = "referral_code"
                case discoverySource = "discovery_source"
            }
        }

        let update = ProfileUpdate(
            onboardingCompleted: true,
            firstName: data.firstName,
            age: data.age,
            gender: data.gender,
            socialContext: data.socialContext,
            quiz1Answer: data.quiz1Answer,
            quiz2Answer: data.quiz2Answer,
            quiz3Answer: data.quiz3Answer,
            selectedGoals: data.selectedGoals,
            referralCode: data.referralCode?.isEmpty == true ? nil : data.referralCode,
            discoverySource: data.discoverySource
        )

        try await client
            .from(DatabaseSchema.UserProfiles.table)
            .update(update)
            .eq(DatabaseSchema.UserProfiles.id, value: userId)
            .execute()
    }
}
