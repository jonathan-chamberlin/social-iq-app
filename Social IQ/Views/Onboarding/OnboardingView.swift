//
//  OnboardingView.swift
//  Social IQ
//

import Mixpanel
import StoreKit
import SwiftUI

struct OnboardingView: View {
    let userId: String
    let onComplete: () -> Void

    private let service = OnboardingService()

    // MARK: - State

    @State private var currentStep = 1
    @State private var quizSubStep = 1 // 1, 2, or 3 within step 1
    @State private var quizAnswers: [Int] = []

    @State private var userName: String = ""
    @State private var userAge: Int = 22
    @State private var selectedGender: String = ""

    // Social context (step 3)
    @State private var selectedSocialContext: String = ""

    // Goal selection (step 9)
    @State private var selectedGoals: Set<String> = []

    // Referral code (step 10)
    @State private var referralCode: String = ""

    // Discovery source (step 12)
    @State private var selectedDiscoverySource: String = ""

    // Completion
    @State private var isCompleting = false

    // Calculating screen
    @State private var calcPhase = 0

    private let totalSteps = 13

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

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
        }
        .animation(.easeInOut(duration: 0.3), value: currentStep)
        .animation(.easeInOut(duration: 0.3), value: quizSubStep)
        .preferredColorScheme(.dark)
        .onAppear {
            AnalyticsService.track(event: .onboardingStarted)
        }
    }

    // MARK: - Progress Dots

    private var progressDots: some View {
        HStack(spacing: 6) {
            ForEach(1...totalSteps, id: \.self) { index in
                Circle()
                    .fill(index <= currentStep ? Color.white : Color.white.opacity(0.3))
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
                case 1: quizStep
                case 2: nameAgeGenderStep
                case 3: socialContextStep
                case 4: calculatingStep
                case 5: scareStep
                case 6: upliftStep
                case 7: socialProofStep
                case 8: chartStep
                case 9: goalSelectionStep
                case 10: referralCodeStep
                case 11: discoverySourceStep
                case 12: ratingPromptStep
                case 13: bridgeToPaywallStep
                default: EmptyView()
                }
            }
        }
    }

    // MARK: - Bottom Bar

    @ViewBuilder
    private var bottomBar: some View {
        if currentStep == 1 || currentStep == 3 || currentStep == 4 || currentStep == 11 || currentStep == 13 {
            // Quiz & social context auto-advance on tap; calculating has no buttons;
            // discovery source auto-advances; step 13 has its own CTAs
            EmptyView()
        } else {
            HStack {
                if showBackButton {
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

    private var showBackButton: Bool {
        currentStep >= 2 && currentStep != 4
    }

    private var canContinue: Bool {
        switch currentStep {
        case 2: return !userName.trimmingCharacters(in: .whitespaces).isEmpty && !selectedGender.isEmpty
        case 9: return !selectedGoals.isEmpty
        default: return true
        }
    }

    private func advance() {
        guard currentStep < totalSteps else { return }
        AnalyticsService.track(event: .onboardingStepCompleted, properties: ["step": currentStep])
        currentStep += 1
    }

    private func goBack() {
        if currentStep == 1 && quizSubStep > 1 {
            quizSubStep -= 1
            quizAnswers.removeLast()
        } else if currentStep > 1 {
            // Skip back over calculating screen
            if currentStep - 1 == 4 {
                currentStep -= 2
            } else {
                currentStep -= 1
            }
        }
    }

    // MARK: - Step 1: Quiz (3 sub-steps)

    @ViewBuilder
    private var quizStep: some View {
        switch quizSubStep {
        case 1:
            quizQuestion(
                question: "What's your biggest social challenge?",
                options: [
                    "Keeping conversations going",
                    "Making strong first impressions",
                    "Reading the room",
                    "Speaking up in groups",
                    "Overthinking after social situations",
                    "Approaching new people confidently",
                ]
            )
        case 2:
            quizQuestion(
                question: "When you meet someone new, you usually...",
                options: [
                    "Wait for them to talk first",
                    "Say hi but run out of things to say",
                    "Talk too much from nerves",
                    "Avoid the situation entirely",
                    "Do fine, but replay it in my head for hours",
                ]
            )
        default:
            quizQuestion(
                question: "How often do you feel like you underperformed socially?",
                options: [
                    "Almost every day",
                    "A few times a week",
                    "Occasionally",
                    "Rarely but when it counts",
                    "Almost never",
                ]
            )
        }
    }

    private func quizQuestion(question: String, options: [String]) -> some View {
        VStack(alignment: .leading, spacing: 24) {
            Text(question)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top, 20)

            VStack(spacing: 12) {
                ForEach(Array(options.enumerated()), id: \.offset) { index, option in
                    Button {
                        selectQuizOption(index)
                    } label: {
                        HStack {
                            Text(option)
                                .font(.body)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.08))
                        )
                    }
                }
            }
        }
    }

    private func selectQuizOption(_ index: Int) {
        quizAnswers.append(index)
        if quizSubStep < 3 {
            quizSubStep += 1
        } else {
            advance()
        }
    }

    // MARK: - Step 2: Name + Age + Gender

    private let genderOptions = ["Male", "Female", "Other", "Prefer not to say"]

    private var nameAgeGenderStep: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Tell us about yourself")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top, 20)

            VStack(alignment: .leading, spacing: 8) {
                Text("First name")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
                TextField(
                    "", text: $userName,
                    prompt: Text("Your first name").foregroundStyle(.white.opacity(0.3))
                )
                .textFieldStyle(.plain)
                .font(.title3)
                .foregroundStyle(.white)
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.08))
                )
                .autocorrectionDisabled()
                .textInputAutocapitalization(.words)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Gender")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
                HStack(spacing: 10) {
                    ForEach(genderOptions, id: \.self) { option in
                        let isSelected = selectedGender == option
                        Button {
                            selectedGender = option
                        } label: {
                            Text(option)
                                .font(.subheadline)
                                .foregroundStyle(isSelected ? .black : .white)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 10)
                                .background(
                                    Capsule()
                                        .fill(isSelected ? Color.white : Color.white.opacity(0.08))
                                )
                        }
                    }
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Age: \(userAge)")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
                Picker("Age", selection: $userAge) {
                    ForEach(13...99, id: \.self) { age in
                        Text("\(age)").tag(age)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 150)
                .clipped()
            }
        }
    }

    // MARK: - Step 3: Social Context (auto-advances on tap)

    private let socialContextOptions = [
        "College campus",
        "Greek life (sorority / fraternity)",
        "Work / professional networking",
        "Social events / parties / bars",
        "Online / dating apps",
        "Small friend groups",
    ]

    private var socialContextStep: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Where do you spend most of your social time?")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top, 20)

            VStack(spacing: 12) {
                ForEach(socialContextOptions, id: \.self) { option in
                    Button {
                        selectedSocialContext = option
                        advance()
                    } label: {
                        HStack {
                            Text(option)
                                .font(.body)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.08))
                        )
                    }
                }
            }
        }
    }

    // MARK: - Step 4: Calculating (auto-advances)

    private var calculatingStep: some View {
        CalculatingView {
            advance()
        }
    }

    // MARK: - Step 5: Scare

    private var scareStep: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Here's what happens without training")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.red)
                .padding(.top, 20)

            VStack(alignment: .leading, spacing: 16) {
                let bullets = scareBullets(for: quizAnswers.first ?? 0)
                ForEach(bullets, id: \.self) { text in
                    scareBullet(text)
                }
            }
        }
    }

    private func scareBullets(for quiz1Answer: Int) -> [String] {
        switch quiz1Answer {
        case 0: // Keeping conversations going
            return [
                "Conversations die and you sit in painful silence",
                "People stop reaching out because the energy always fades",
                "You leave every interaction wishing you'd said more",
                "The people you want to know drift away without understanding why",
            ]
        case 1: // Making strong first impressions
            return [
                "People form their opinion of you in the first 7 seconds",
                "You get one shot at a first meeting — and right now you're winging it",
                "Forgettable introductions mean missed jobs, dates, and friendships",
                "The version of you people remember isn't the real you",
            ]
        case 2: // Reading the room
            return [
                "You miss the signals that tell you when to speak and when to listen",
                "You say the wrong thing at the wrong time and only realize later",
                "People think you don't care — but you just didn't notice",
                "Social cues everyone else seems to get feel invisible to you",
            ]
        case 3: // Speaking up in groups
            return [
                "Your ideas die in your head because the moment passes",
                "The loud people get the credit while you stay invisible",
                "You rehearse what to say, but by the time you're ready, the topic changed",
                "People assume you have nothing to add — but you have everything to add",
            ]
        case 4: // Overthinking after social situations
            return [
                "A good night gets ruined by 3am self-doubt",
                "You replay every word you said, searching for what went wrong",
                "One awkward moment loops in your head for days",
                "You cancel plans to avoid the post-social spiral",
            ]
        case 5: // Approaching new people confidently
            return [
                "You see someone you want to meet and walk right past them",
                "The moment passes and you spend the rest of the night thinking \"what if\"",
                "Your friend group stays the same size while opportunities walk by",
                "The people you most want to know never find out you exist",
            ]
        default:
            return [
                "Awkward silences kill your confidence. And people notice.",
                "Opportunities pass because you can't connect",
                "You overthink every interaction, then replay it for hours",
                "The gap between your potential and your presence keeps growing",
            ]
        }
    }

    private func scareBullet(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Text("⚠️")
                .font(.title3)
            Text(text)
                .font(.body)
                .foregroundStyle(.white.opacity(0.9))
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.red.opacity(0.1))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.red.opacity(0.3), lineWidth: 1)
        )
    }

    // MARK: - Completion Flow

    private func completeOnboardingAndDismiss() {
        guard !isCompleting else { return }
        isCompleting = true
        Task {
            do {
                try await service.completeOnboarding(
                    userId: userId,
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
            } catch {
                // Best-effort save — don't block the user
            }
            AnalyticsService.track(event: .onboardingCompleted)
            onComplete()
        }
    }

    // MARK: - Step 6: Uplift

    private var upliftStep: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("But you're already ahead")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.green)
                .padding(.top, 20)

            Text(
                "Most people never realize social skills are trainable. You did. Social IQ uses the same deliberate practice frameworks that athletes and top performers use. Adapted for real social situations."
            )
            .font(.body)
            .foregroundStyle(.white.opacity(0.9))
            .lineSpacing(6)
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.green.opacity(0.08))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.green.opacity(0.3), lineWidth: 1)
            )

            Image(systemName: "arrow.up.right")
                .font(.system(size: 60))
                .foregroundStyle(.green.opacity(0.3))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 20)
        }
    }

    // MARK: - Step 7: Social Proof

    private var socialProofStep: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What others are saying")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top, 20)

            testimonialCard(
                name: "Theo",
                duration: "2 weeks in",
                text: "I used to dread networking events. After 2 weeks, I actually look forward to them. My conversations feel natural now."
            )
            testimonialCard(
                name: "Andre",
                duration: "1 month in",
                text: "It's like Duolingo but I actually see results every day."
            )
            testimonialCard(
                name: "Aryaman",
                duration: "3 weeks in",
                text: "I wish I started using this sooner."
            )
        }
    }

    private func testimonialCard(name: String, duration: String, text: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 2) {
                ForEach(0..<5, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundStyle(.yellow)
                }
            }

            Text(text)
                .font(.subheadline)
                .foregroundStyle(.white)
                .lineSpacing(4)

            HStack(spacing: 6) {
                Text(name)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Text("·")
                    .foregroundStyle(.white.opacity(0.5))
                Text(duration)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.11, green: 0.11, blue: 0.118))
        )
    }

    // MARK: - Step 8: Chart

    private var chartStep: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Your Social Confidence Over Time")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top, 20)

            confidenceChart
                .frame(height: 200)
                .padding(.top, 8)

            HStack {
                chartLegendDot(color: .green, label: "With Social IQ")
                Spacer()
                chartLegendDot(color: .gray, label: "Without training")
            }
        }
    }

    private var confidenceChart: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            let labelHeight: CGFloat = 20
            let chartH = h - labelHeight

            ZStack(alignment: .bottomLeading) {
                // Grid lines
                ForEach(0..<4, id: \.self) { i in
                    let y = chartH * CGFloat(i) / 3
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: w, y: y))
                    }
                    .stroke(Color.white.opacity(0.06), lineWidth: 1)
                }

                // "Without training" line — flat
                Path { path in
                    path.move(to: CGPoint(x: 0, y: chartH * 0.75))
                    path.addLine(to: CGPoint(x: w, y: chartH * 0.7))
                }
                .stroke(Color.gray.opacity(0.5), lineWidth: 2)

                // "With Social IQ" line — curves upward
                Path { path in
                    path.move(to: CGPoint(x: 0, y: chartH * 0.75))
                    path.addCurve(
                        to: CGPoint(x: w, y: chartH * 0.1),
                        control1: CGPoint(x: w * 0.35, y: chartH * 0.65),
                        control2: CGPoint(x: w * 0.65, y: chartH * 0.2)
                    )
                }
                .stroke(Color.green, lineWidth: 6)

                // X-axis labels
                HStack {
                    Text("Week 1")
                    Spacer()
                    Text("Week 4")
                    Spacer()
                    Text("Week 8")
                }
                .padding(.horizontal, 16)
                .font(.caption2)
                .foregroundStyle(.white.opacity(0.5))
                .offset(y: labelHeight / 2)
                .frame(width: w, height: labelHeight, alignment: .bottom)
                .offset(y: labelHeight)
            }
        }
    }

    private func chartLegendDot(color: Color, label: String) -> some View {
        HStack(spacing: 6) {
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)
            Text(label)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.7))
        }
    }

    // MARK: - Step 9: Goal Selection

    private let goalOptions = [
        "Be more charismatic",
        "Read people instantly",
        "Handle conflict confidently",
        "Make lasting impressions",
        "Lead any conversation",
        "Eliminate social anxiety",
        "Stop overthinking social situations",
        "Approach people I'm interested in",
        "Be comfortable outside my friend group",
    ]

    private var goalSelectionStep: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What do you want to master?")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top, 20)

            Text("Pick up to 3")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.5))

            WrappingHStack(items: goalOptions, spacing: 10, lineSpacing: 10) { goal in
                let isSelected = selectedGoals.contains(goal)
                Button {
                    if isSelected {
                        selectedGoals.remove(goal)
                    } else if selectedGoals.count < 3 {
                        selectedGoals.insert(goal)
                    }
                } label: {
                    Text(goal)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(isSelected ? .black : .white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(
                            Capsule()
                                .fill(isSelected ? Color.white : Color.white.opacity(0.08))
                        )
                }
            }
            .padding(.top, 8)
        }
    }

    // MARK: - Step 10: Referral Code

    private var referralCodeStep: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Got a referral code?")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top, 20)

            TextField(
                "", text: $referralCode,
                prompt: Text("Enter code").foregroundStyle(.white.opacity(0.3))
            )
            .textFieldStyle(.plain)
            .font(.title3)
            .foregroundStyle(.white)
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.08))
            )
            .autocorrectionDisabled()
            .textInputAutocapitalization(.characters)

            Button {
                advance()
            } label: {
                Text("Skip")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.5))
                    .frame(maxWidth: .infinity)
            }
        }
    }

    // MARK: - Step 11: Discovery Source (auto-advances on tap)

    private let discoverySourceOptions = [
        "Friend / word of mouth",
        "Social media (TikTok, Instagram, etc.)",
        "App Store search",
        "Greek life / sorority / fraternity",
        "Other",
    ]

    private var discoverySourceStep: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("How did you hear about us?")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top, 20)

            VStack(spacing: 12) {
                ForEach(discoverySourceOptions, id: \.self) { option in
                    Button {
                        selectedDiscoverySource = option
                        advance()
                    } label: {
                        HStack {
                            Text(option)
                                .font(.body)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.08))
                        )
                    }
                }
            }
        }
    }

    // MARK: - Step 12: Rating Prompt

    private var ratingPromptStep: some View {
        VStack(spacing: 24) {
            Spacer().frame(height: 40)

            Image(systemName: "star.bubble")
                .font(.system(size: 60))
                .foregroundStyle(.yellow.opacity(0.8))

            Text("Enjoying Social IQ?")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)

            Text("A quick rating helps other people discover Social IQ")
                .font(.body)
                .foregroundStyle(.white.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            requestAppReview()
        }
    }

    private func requestAppReview() {
        #if !DEBUG
        if let scene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
        #endif
    }

    // MARK: - Step 13: Bridge to Paywall

    private var bridgeToPaywallStep: some View {
        VStack(spacing: 24) {
            Spacer().frame(height: 40)

            Image(systemName: "flame.fill")
                .font(.system(size: 60))
                .foregroundStyle(.orange)

            Text("Invest in yourself")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)

            Text("You've taken the first step. Your custom training plan is ready.")
                .font(.body)
                .foregroundStyle(.white.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)

            Button {
                SuperwallService.presentPaywallWithHandler(placement: .onboardingComplete) {
                    completeOnboardingAndDismiss()
                }
            } label: {
                Text("Start My Training")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        Capsule()
                            .fill(Color.green)
                    )
            }

            Button {
                UserDefaults.standard.set(true, forKey: "shouldAutoOpenLesson1")
                completeOnboardingAndDismiss()
            } label: {
                Text("Start with free lesson")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.5))
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    OnboardingView(userId: UUID().uuidString) {
        print("Onboarding complete")
    }
}
