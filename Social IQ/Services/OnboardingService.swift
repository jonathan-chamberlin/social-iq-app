//
//  OnboardingService.swift
//  Social IQ
//

import Foundation
import Supabase

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

    func completeOnboarding(
        userId: String,
        firstName: String,
        age: Int,
        quiz1Answer: String?,
        quiz2Answer: String?,
        quiz3Answer: String?,
        selectedGoals: [String],
        referralCode: String?
    ) async throws {
        struct ProfileUpdate: Encodable {
            let onboardingCompleted: Bool
            let firstName: String
            let age: Int
            let quiz1Answer: String?
            let quiz2Answer: String?
            let quiz3Answer: String?
            let selectedGoals: [String]
            let referralCode: String?

            enum CodingKeys: String, CodingKey {
                case onboardingCompleted = "onboarding_completed"
                case firstName = "first_name"
                case age
                case quiz1Answer = "quiz1_answer"
                case quiz2Answer = "quiz2_answer"
                case quiz3Answer = "quiz3_answer"
                case selectedGoals = "selected_goals"
                case referralCode = "referral_code"
            }
        }

        let update = ProfileUpdate(
            onboardingCompleted: true,
            firstName: firstName,
            age: age,
            quiz1Answer: quiz1Answer,
            quiz2Answer: quiz2Answer,
            quiz3Answer: quiz3Answer,
            selectedGoals: selectedGoals,
            referralCode: referralCode?.isEmpty == true ? nil : referralCode
        )

        try await client
            .from(DatabaseSchema.UserProfiles.table)
            .update(update)
            .eq(DatabaseSchema.UserProfiles.id, value: userId)
            .execute()
    }
}
