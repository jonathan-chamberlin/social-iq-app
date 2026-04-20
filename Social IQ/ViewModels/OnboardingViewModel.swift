//
//  OnboardingViewModel.swift
//  Social IQ
//
//  State, navigation, analytics, and completion logic for the onboarding flow.
//  OnboardingView owns the view hierarchy; this class owns everything else.
//

import Foundation
import Mixpanel

@Observable
final class OnboardingViewModel {
    let userId: String
    private let onComplete: () -> Void
    private let service = OnboardingService()

    // MARK: - Step State

    var currentStep: OnboardingStep = .quiz
    var quizSubStep: QuizSubStep = .challenge
    var quizAnswers: [Int] = []

    // MARK: - User Input

    var userName: String = ""
    var userAge: Int = 22
    var selectedGender: String = ""
    var selectedSocialContext: String = ""
    var selectedGoals: Set<String> = []
    var referralCode: String = ""
    var selectedDiscoverySource: String = ""

    // MARK: - Internal State

    private var isCompleting = false
    var stepEnteredAt: Date = .now

    // MARK: - Option Data

    static let socialContextOptions = [
        "College campus",
        "Greek life (sorority / fraternity)",
        "Work / professional networking",
        "Social events / parties / bars",
        "Online / dating apps",
        "Small friend groups",
    ]

    static let discoverySourceOptions = [
        "Reddit",
        "Instagram",
        "TikTok",
        "Friend / word of mouth",
        "App Store search",
        "Greek life / sorority / fraternity",
        "Other",
    ]

    // MARK: - Init

    init(userId: String, appleFirstName: String?, onComplete: @escaping () -> Void) {
        self.userId = userId
        self.onComplete = onComplete
        if let appleFirstName, !appleFirstName.isEmpty {
            self.userName = appleFirstName
        }
    }

    // MARK: - Analytics

    var currentAnalyticsName: String {
        currentStep == .quiz ? quizSubStep.analyticsName : currentStep.analyticsName
    }

    func trackStepCompleted(extraProperties: [String: MixpanelType] = [:]) {
        let duration = Int(Date().timeIntervalSince(stepEnteredAt))
        var properties: [String: MixpanelType] = [
            "step": currentStep.stepNumber,
            "step_name": currentAnalyticsName,
            "duration_seconds": duration,
        ]
        for (key, value) in extraProperties {
            properties[key] = value
        }
        AnalyticsService.track(event: .onboardingStepCompleted, properties: properties)
    }

    func trackAbandoned() {
        let duration = Int(Date().timeIntervalSince(stepEnteredAt))
        AnalyticsService.track(event: .onboardingAbandoned, properties: [
            "last_step": currentStep.stepNumber,
            "last_step_name": currentAnalyticsName,
            "duration_seconds": duration,
        ])
    }

    // MARK: - Navigation

    var canContinue: Bool {
        switch currentStep {
        case .nameAgeGender:
            !selectedGender.isEmpty
        case .goalSelection:
            !selectedGoals.isEmpty
        default:
            true
        }
    }

    func advance() {
        guard let nextStep = currentStep.next else { return }
        trackStepCompleted(extraProperties: quizAnswerProperty())
        currentStep = nextStep
        stepEnteredAt = .now
    }

    func goBack() {
        if currentStep == .quiz, let prevSub = quizSubStep.previous {
            quizSubStep = prevSub
            quizAnswers.removeLast()
        } else if let prevStep = currentStep.previous {
            currentStep = prevStep
        }
        stepEnteredAt = .now
    }

    func selectQuizOption(_ index: Int) {
        quizAnswers.append(index)
        if let nextSub = quizSubStep.next {
            let options = quizSubStep.options
            var extra: [String: MixpanelType] = [:]
            if index < options.count {
                extra["answer"] = options[index]
            }
            trackStepCompleted(extraProperties: extra)
            quizSubStep = nextSub
            stepEnteredAt = .now
        } else {
            advance()
        }
    }

    // MARK: - Completion

    func completeOnboardingAndDismiss() {
        guard !isCompleting else { return }
        isCompleting = true
        trackStepCompleted()
        Task {
            do {
                let onboardingData = OnboardingData(
                    firstName: userName,
                    age: userAge,
                    gender: selectedGender.isEmpty ? nil : selectedGender,
                    socialContext: selectedSocialContext.isEmpty ? nil : selectedSocialContext,
                    quiz1Answer: quizAnswers.indices.contains(0) ? String(quizAnswers[0]) : nil,
                    quiz2Answer: quizAnswers.indices.contains(1) ? String(quizAnswers[1]) : nil,
                    quiz3Answer: quizAnswers.indices.contains(2) ? String(quizAnswers[2]) : nil,
                    selectedGoals: Array(selectedGoals),
                    referralCode: referralCode.isEmpty ? nil : referralCode,
                    discoverySource: selectedDiscoverySource.isEmpty ? nil : selectedDiscoverySource
                )
                try await service.completeOnboarding(userId: userId, data: onboardingData)
            } catch {
                // Best-effort save — don't block the user
            }
            AnalyticsService.setUserProperties(buildUserProperties())
            AnalyticsService.track(event: .onboardingCompleted)
            onComplete()
        }
    }

    // MARK: - Private Helpers

    private func quizAnswerProperty() -> [String: MixpanelType] {
        guard currentStep == .quiz, let lastAnswer = quizAnswers.last else { return [:] }
        let options = quizSubStep.options
        guard lastAnswer < options.count else { return [:] }
        return ["answer": options[lastAnswer]]
    }

    private func buildUserProperties() -> [String: MixpanelType] {
        var userProps: [String: MixpanelType] = [
            "first_name": userName,
            "age": userAge,
        ]
        if !selectedGender.isEmpty { userProps["gender"] = selectedGender }
        if !selectedSocialContext.isEmpty { userProps["social_context"] = selectedSocialContext }
        if !selectedGoals.isEmpty { userProps["goals"] = Array(selectedGoals).joined(separator: ", ") }
        if !selectedDiscoverySource.isEmpty { userProps["discovery_source"] = selectedDiscoverySource }
        if quizAnswers.indices.contains(0) {
            let q1 = QuizSubStep.challenge.options
            if quizAnswers[0] < q1.count { userProps["quiz_challenge"] = q1[quizAnswers[0]] }
        }
        if quizAnswers.indices.contains(1) {
            let q2 = QuizSubStep.meetNew.options
            if quizAnswers[1] < q2.count { userProps["quiz_meet_new"] = q2[quizAnswers[1]] }
        }
        if quizAnswers.indices.contains(2) {
            let q3 = QuizSubStep.underperform.options
            if quizAnswers[2] < q3.count { userProps["quiz_underperform"] = q3[quizAnswers[2]] }
        }
        return userProps
    }
}
