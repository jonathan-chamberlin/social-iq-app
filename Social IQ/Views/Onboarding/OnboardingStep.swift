//
//  OnboardingStep.swift
//  Social IQ
//

import Foundation

// MARK: - Onboarding Step Enum

enum OnboardingStep: Int, CaseIterable {
    case quiz
    case nameAgeGender
    case socialContext
    case calculating
    case scare
    case uplift
    case socialProof
    case chart
    case goalSelection
    case referralCode
    case discoverySource
    case ratingPrompt
    case bridgeToPaywall

    var analyticsName: String {
        switch self {
        case .quiz: "quiz"
        case .nameAgeGender: "name_age_gender"
        case .socialContext: "social_context"
        case .calculating: "calculating"
        case .scare: "scare"
        case .uplift: "uplift"
        case .socialProof: "social_proof"
        case .chart: "chart"
        case .goalSelection: "goal_selection"
        case .referralCode: "referral_code"
        case .discoverySource: "discovery_source"
        case .ratingPrompt: "rating_prompt"
        case .bridgeToPaywall: "bridge_to_paywall"
        }
    }

    var autoAdvances: Bool {
        switch self {
        case .quiz, .socialContext, .calculating, .discoverySource, .bridgeToPaywall:
            true
        default:
            false
        }
    }

    var showsBackButton: Bool {
        switch self {
        case .quiz, .calculating:
            false
        default:
            true
        }
    }

    var next: OnboardingStep? {
        let all = Self.allCases
        guard let idx = all.firstIndex(of: self), idx + 1 < all.count else { return nil }
        return all[all.index(after: idx)]
    }

    var previous: OnboardingStep? {
        let all = Self.allCases
        guard let idx = all.firstIndex(of: self), idx > all.startIndex else { return nil }
        let prev = all[all.index(before: idx)]
        // Skip calculating when going back — it's a non-interactive animation screen
        if prev == .calculating { return prev.previous }
        return prev
    }

    var stepNumber: Int {
        (Self.allCases.firstIndex(of: self) ?? 0) + 1
    }

    static var totalCount: Int { allCases.count }
}

// MARK: - Quiz Sub-Step

enum QuizSubStep: Int, CaseIterable {
    case challenge = 1
    case meetNew = 2
    case underperform = 3

    var analyticsName: String {
        switch self {
        case .challenge: "quiz_challenge"
        case .meetNew: "quiz_meet_new"
        case .underperform: "quiz_underperform"
        }
    }

    var question: String {
        switch self {
        case .challenge: "What's your biggest social challenge?"
        case .meetNew: "When you meet someone new, you usually..."
        case .underperform: "How often do you feel like you underperformed socially?"
        }
    }

    var options: [String] {
        switch self {
        case .challenge:
            [
                "Keeping conversations going",
                "Making strong first impressions",
                "Reading the room",
                "Speaking up in groups",
                "Overthinking after social situations",
                "Approaching new people confidently",
            ]
        case .meetNew:
            [
                "Wait for them to talk first",
                "Say hi but run out of things to say",
                "Talk too much from nerves",
                "Avoid the situation entirely",
                "Do fine, but replay it in my head for hours",
            ]
        case .underperform:
            [
                "Almost every day",
                "A few times a week",
                "Occasionally",
                "Rarely but when it counts",
                "Almost never",
            ]
        }
    }

    var next: QuizSubStep? {
        QuizSubStep(rawValue: rawValue + 1)
    }

    var previous: QuizSubStep? {
        QuizSubStep(rawValue: rawValue - 1)
    }
}
