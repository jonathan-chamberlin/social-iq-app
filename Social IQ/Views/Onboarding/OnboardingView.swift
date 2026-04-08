//
//  OnboardingView.swift
//  Social IQ
//
//  Coordinator: owns state, navigation, and analytics.
//  Each step's UI lives in its own file (OnboardingQuizStep, OnboardingScareStep, etc.).
//

import Mixpanel
import SwiftUI

struct OnboardingView: View {
    let userId: String
    let onComplete: () -> Void
    @Environment(\.scenePhase) private var scenePhase

    private let service = OnboardingService()

    // MARK: - State

    @State private var currentStep: OnboardingStep = .quiz
    @State private var quizSubStep: QuizSubStep = .challenge
    @State private var quizAnswers: [Int] = []

    @State private var userName: String = ""
    @State private var userAge: Int = 22
    @State private var selectedGender: String = ""
    @State private var selectedSocialContext: String = ""
    @State private var selectedGoals: Set<String> = []
    @State private var referralCode: String = ""
    @State private var selectedDiscoverySource: String = ""

    @State private var isCompleting = false
    @State private var stepEnteredAt: Date = .now

    // MARK: - Option Data

    private static let socialContextOptions = [
        "College campus",
        "Greek life (sorority / fraternity)",
        "Work / professional networking",
        "Social events / parties / bars",
        "Online / dating apps",
        "Small friend groups",
    ]

    private static let discoverySourceOptions = [
        "Reddit",
        "Instagram",
        "TikTok",
        "Friend / word of mouth",
        "App Store search",
        "Greek life / sorority / fraternity",
        "Other",
    ]

    // MARK: - Analytics Helpers

    private var currentAnalyticsName: String {
        if currentStep == .quiz {
            return quizSubStep.analyticsName
        }
        return currentStep.analyticsName
    }

    private func trackStepCompleted(extraProperties: [String: MixpanelType] = [:]) {
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

    // MARK: - Body

    var body: some View {
        VStack(spacing: 0) {
            progressDots
                .padding(.top, 12)
                .padding(.bottom, 24)

            stepContent
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .id("\(currentStep)-\(quizSubStep)")
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing),
                    removal: .move(edge: .leading)
                ))

            bottomBar
                .padding(.bottom, 16)
        }
        .padding(.horizontal, 24)
        .screenBackground()
        .animation(.easeInOut(duration: 0.3), value: currentStep)
        .animation(.easeInOut(duration: 0.3), value: quizSubStep)
        .preferredColorScheme(.dark)
        .onAppear {
            AnalyticsService.track(event: .onboardingStarted)
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .background, currentStep != .bridgeToPaywall {
                let duration = Int(Date().timeIntervalSince(stepEnteredAt))
                AnalyticsService.track(event: .onboardingAbandoned, properties: [
                    "last_step": currentStep.stepNumber,
                    "last_step_name": currentAnalyticsName,
                    "duration_seconds": duration,
                ])
            }
        }
    }

    // MARK: - Progress Dots

    private var progressDots: some View {
        HStack(spacing: 6) {
            ForEach(OnboardingStep.allCases, id: \.self) { step in
                Circle()
                    .fill(step.stepNumber <= currentStep.stepNumber ? Color.white : Color.white.opacity(0.3))
                    .frame(width: 8, height: 8)
            }
        }
    }

    // MARK: - Step Content

    @ViewBuilder
    private var stepContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                switch currentStep {
                case .quiz:
                    OnboardingQuizStep(subStep: quizSubStep, onSelectOption: selectQuizOption)
                case .nameAgeGender:
                    OnboardingNameAgeGenderStep(
                        userName: $userName, userAge: $userAge, selectedGender: $selectedGender
                    )
                case .socialContext:
                    OnboardingOptionListStep(
                        title: "Where do you spend most of your social time?",
                        options: Self.socialContextOptions
                    ) { option in
                        selectedSocialContext = option
                        advance()
                    }
                case .calculating:
                    CalculatingView { advance() }
                case .scare:
                    OnboardingScareStep(quiz1Answer: quizAnswers.first ?? 0)
                case .uplift:
                    OnboardingUpliftStep()
                case .socialProof:
                    OnboardingSocialProofStep()
                case .chart:
                    OnboardingChartStep()
                case .goalSelection:
                    OnboardingGoalSelectionStep(selectedGoals: $selectedGoals)
                case .referralCode:
                    OnboardingReferralCodeStep(referralCode: $referralCode, onSkip: advance)
                case .discoverySource:
                    OnboardingOptionListStep(
                        title: "How did you hear about us?",
                        options: Self.discoverySourceOptions
                    ) { option in
                        selectedDiscoverySource = option
                        advance()
                    }
                case .ratingPrompt:
                    OnboardingRatingPromptStep()
                case .bridgeToPaywall:
                    OnboardingBridgeToPaywallStep(
                        onStartTraining: {
                            UserDefaults.standard.set(true, forKey: AppConstants.shouldAutoOpenLesson1Key)
                            SuperwallService.presentPaywall(placement: .onboardingComplete) {
                                completeOnboardingAndDismiss()
                            }
                        },
                        onFreeLesson: {
                            UserDefaults.standard.set(true, forKey: AppConstants.shouldAutoOpenLesson1Key)
                            completeOnboardingAndDismiss()
                        }
                    )
                }
            }
        }
    }

    // MARK: - Bottom Bar

    @ViewBuilder
    private var bottomBar: some View {
        if currentStep.autoAdvances {
            EmptyView()
        } else {
            HStack {
                if currentStep.showsBackButton {
                    Button {
                        goBack()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .foregroundStyle(.white.opacity(0.6))
                            .frame(width: 44, height: 50)
                    }
                }

                Button {
                    advance()
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            Capsule()
                                .fill(canContinue ? Color.white.opacity(0.15) : Color.white.opacity(0.05))
                        )
                }
                .disabled(!canContinue)
            }
        }
    }

    // MARK: - Navigation Logic

    private var canContinue: Bool {
        switch currentStep {
        case .nameAgeGender:
            !userName.trimmingCharacters(in: .whitespaces).isEmpty && !selectedGender.isEmpty
        case .goalSelection:
            !selectedGoals.isEmpty
        default:
            true
        }
    }

    private func advance() {
        guard let nextStep = currentStep.next else { return }
        trackStepCompleted(extraProperties: quizAnswerProperty())
        currentStep = nextStep
        stepEnteredAt = .now
    }

    private func goBack() {
        if currentStep == .quiz, let prevSub = quizSubStep.previous {
            quizSubStep = prevSub
            quizAnswers.removeLast()
        } else if let prevStep = currentStep.previous {
            currentStep = prevStep
        }
        stepEnteredAt = .now
    }

    private func quizAnswerProperty() -> [String: MixpanelType] {
        guard currentStep == .quiz, let lastAnswer = quizAnswers.last else { return [:] }
        let options = quizSubStep.options
        guard lastAnswer < options.count else { return [:] }
        return ["answer": options[lastAnswer]]
    }

    private func selectQuizOption(_ index: Int) {
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

    // MARK: - Completion Flow

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

    private func completeOnboardingAndDismiss() {
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
}

#Preview {
    OnboardingView(userId: UUID().uuidString) {
        print("Onboarding complete")
    }
}
