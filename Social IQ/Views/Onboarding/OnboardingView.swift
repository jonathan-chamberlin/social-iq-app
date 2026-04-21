//
//  OnboardingView.swift
//  Social IQ
//
//  View coordinator: renders the step UI and wires events to OnboardingViewModel.
//  All state, navigation, and analytics live in OnboardingViewModel.
//

import SwiftUI

struct OnboardingView: View {
    @State private var viewModel: OnboardingViewModel
    @Environment(\.scenePhase) private var scenePhase

    private enum ContinueButton {
        // Active vs disabled fill opacity for the Continue capsule button.
        // Not in Theme.Opacity because these are button-specific affordance values.
        static let activeOpacity: Double = 0.15
        static let disabledOpacity: Double = 0.05
    }

    init(userId: String, appleFirstName: String?, onComplete: @escaping () -> Void) {
        _viewModel = State(initialValue: OnboardingViewModel(
            userId: userId,
            appleFirstName: appleFirstName,
            onComplete: onComplete
        ))
    }

    var body: some View {
        VStack(spacing: 0) {
            if viewModel.currentStep != .welcome {
                progressDots
                    .padding(.top, 12)
                    .padding(.bottom, 24)
            }

            stepContent
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .id("\(viewModel.currentStep)-\(viewModel.quizSubStep)")
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing),
                    removal: .move(edge: .leading)
                ))

            bottomBar
                .padding(.bottom, 16)
        }
        .padding(.horizontal, 24)
        .screenBackground()
        .animation(.easeInOut(duration: 0.3), value: viewModel.currentStep)
        .animation(.easeInOut(duration: 0.3), value: viewModel.quizSubStep)
        .preferredColorScheme(.dark)
        .onAppear {
            AnalyticsService.track(event: .onboardingStarted)
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .background, viewModel.currentStep != .bridgeToPaywall {
                viewModel.trackAbandoned()
            }
        }
    }

    // MARK: - Progress Dots

    private var progressDots: some View {
        HStack(spacing: 6) {
            ForEach(OnboardingStep.allCases, id: \.self) { step in
                Circle()
                    .fill(step.stepNumber <= viewModel.currentStep.stepNumber
                          ? Color.white
                          : Color.white.opacity(Theme.Opacity.disabled))
                    .frame(width: 8, height: 8)
            }
        }
    }

    // MARK: - Step Content

    @ViewBuilder
    private var stepContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                switch viewModel.currentStep {
                case .welcome:
                    OnboardingWelcomeStep(onGetStarted: viewModel.advance)
                case .quiz:
                    OnboardingQuizStep(
                        subStep: viewModel.quizSubStep,
                        onSelectOption: viewModel.selectQuizOption
                    )
                case .nameAgeGender:
                    OnboardingNameAgeGenderStep(
                        userAge: $viewModel.userAge,
                        selectedGender: $viewModel.selectedGender
                    )
                case .socialContext:
                    OnboardingOptionListStep(
                        title: "Where do you spend most of your social time?",
                        options: OnboardingViewModel.socialContextOptions
                    ) { option in
                        viewModel.selectedSocialContext = option
                        viewModel.advance()
                    }
                case .calculating:
                    CalculatingView { viewModel.advance() }
                case .scare:
                    OnboardingScareStep(quiz1Answer: viewModel.quizAnswers.first ?? 0)
                case .uplift:
                    OnboardingUpliftStep()
                case .socialProof:
                    OnboardingSocialProofStep()
                case .chart:
                    OnboardingChartStep()
                case .goalSelection:
                    OnboardingGoalSelectionStep(selectedGoals: $viewModel.selectedGoals)
                case .referralCode:
                    OnboardingReferralCodeStep(
                        referralCode: $viewModel.referralCode,
                        onSkip: viewModel.advance
                    )
                case .discoverySource:
                    OnboardingOptionListStep(
                        title: "How did you hear about us?",
                        options: OnboardingViewModel.discoverySourceOptions
                    ) { option in
                        viewModel.selectedDiscoverySource = option
                        viewModel.advance()
                    }
                case .ratingPrompt:
                    OnboardingRatingPromptStep()
                case .bridgeToPaywall:
                    OnboardingBridgeToPaywallStep(
                        onStartTraining: {
                            UserDefaults.standard.set(true, forKey: AppConstants.shouldAutoOpenLesson1Key)
                            SuperwallService.presentPaywallWithHandler(placement: .onboardingComplete) {
                                viewModel.completeOnboardingAndDismiss()
                            }
                        },
                        onFreeLesson: {
                            UserDefaults.standard.set(true, forKey: AppConstants.shouldAutoOpenLesson1Key)
                            viewModel.completeOnboardingAndDismiss()
                        }
                    )
                }
            }
        }
    }

    // MARK: - Bottom Bar

    @ViewBuilder
    private var bottomBar: some View {
        if viewModel.currentStep.autoAdvances {
            EmptyView()
        } else {
            HStack {
                if viewModel.currentStep.showsBackButton {
                    Button {
                        viewModel.goBack()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .foregroundStyle(.white.opacity(Theme.Opacity.muted))
                            .frame(width: 44, height: 50)
                    }
                }

                Button {
                    viewModel.advance()
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            Capsule()
                                .fill(viewModel.canContinue
                                      ? Color.white.opacity(ContinueButton.activeOpacity)
                                      : Color.white.opacity(ContinueButton.disabledOpacity))
                        )
                }
                .disabled(!viewModel.canContinue)
            }
        }
    }
}

#Preview {
    OnboardingView(userId: UUID().uuidString, appleFirstName: "Jane") {
        // Preview completion
    }
}
