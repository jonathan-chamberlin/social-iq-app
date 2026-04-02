//
//  OnboardingViewModel.swift
//  Social IQ
//

import Foundation

@Observable
final class OnboardingViewModel {
    enum Step: Int, CaseIterable {
        case quiz1 = 0
        case quiz2
        case quiz3
        case nameAge
        case calculating
        case scare
        case uplift
        case socialProof
        case chart
        case goalSelection
        case referralCode
        case ratingPrompt
        case bridgeToPaywall
    }

    var currentStep: Step = .quiz1

    // Quiz answers
    var quiz1Answer: String?
    var quiz2Answer: String?
    var quiz3Answer: String?

    // Name + Age
    var firstName: String = ""
    var age: Int = 25

    // Goal selection
    var selectedGoals: Set<String> = []

    // Referral code
    var referralCode: String = ""

    // State
    var isCompleting: Bool = false
    var error: String?

    var canContinue: Bool {
        switch currentStep {
        case .quiz1: return quiz1Answer != nil
        case .quiz2: return quiz2Answer != nil
        case .quiz3: return quiz3Answer != nil
        case .nameAge: return !firstName.trimmingCharacters(in: .whitespaces).isEmpty
        case .calculating: return false
        case .goalSelection: return !selectedGoals.isEmpty
        case .referralCode: return true
        default: return true
        }
    }

    var showBackButton: Bool {
        currentStep.rawValue > Step.quiz1.rawValue && currentStep != .calculating
    }

    var totalSteps: Int { Step.allCases.count }
    var currentStepIndex: Int { currentStep.rawValue }

    func advance() {
        guard let next = Step(rawValue: currentStep.rawValue + 1) else { return }
        currentStep = next
    }

    func goBack() {
        guard currentStep.rawValue > 0,
              let prev = Step(rawValue: currentStep.rawValue - 1) else { return }
        // Skip back over calculating screen
        if prev == .calculating {
            if let beforeCalc = Step(rawValue: prev.rawValue - 1) {
                currentStep = beforeCalc
            }
        } else {
            currentStep = prev
        }
    }

    func toggleGoal(_ goal: String) {
        if selectedGoals.contains(goal) {
            selectedGoals.remove(goal)
        } else if selectedGoals.count < 3 {
            selectedGoals.insert(goal)
        }
    }
}
