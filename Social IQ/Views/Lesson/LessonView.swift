//
//  LessonView.swift
//  Social IQ
//

import SwiftUI

struct LessonView: View {
    var lesson: Lesson
    var userId: String?
    var onComplete: (() -> Void)?
    @State private var viewModel = LessonViewModel()
    @Environment(\.dismiss) private var dismiss

    private static let stepLabels = ["READ", "THINK", "SPEAK"]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if viewModel.isComplete {
                LessonCompletionView(score: viewModel.score, totalSteps: lesson.steps.count) {
                    dismiss()
                }
            } else if let step = viewModel.currentStep {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 20) {
                            stepIndicator(currentLabel: step.label)
                            scenarioCard(step: step)
                            questionText(step: step)
                            optionCards(step: step)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                        .padding(.bottom, 40)
                    }
                    .onChange(of: viewModel.showFeedback) { _, showing in
                        if showing, let selected = viewModel.selectedOptionIndex {
                            withAnimation {
                                proxy.scrollTo("option-\(selected)", anchor: .center)
                            }
                            // Track per-question answer
                            if let step = viewModel.currentStep {
                                let timeToAnswer = Int(Date().timeIntervalSince(viewModel.questionStartedAt))
                                AnalyticsService.track(event: .questionAnswered, properties: [
                                    "lesson_id": lesson.id,
                                    "question_number": viewModel.currentStepIndex + 1,
                                    "question_type": step.label,
                                    "answer_index": selected,
                                    "is_correct": step.options[selected].feedback.isCorrect,
                                    "time_to_answer_seconds": timeToAnswer,
                                ])
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .onAppear {
            viewModel.startLesson(lesson)
            AnalyticsService.track(event: .lessonStarted, properties: ["lesson_id": lesson.id])
        }
        .onChange(of: viewModel.isComplete) { _, complete in
            if complete, let userId {
                AnalyticsService.track(event: .lessonCompleted, properties: ["lesson_id": lesson.id])
                Task {
                    await viewModel.saveProgress(userId: userId)
                    onComplete?()
                }
            }
        }
    }

    // MARK: - Step Indicator

    private func stepIndicator(currentLabel: String) -> some View {
        let currentIndex = Self.stepLabels.firstIndex(of: currentLabel) ?? 0

        return HStack(spacing: 0) {
            ForEach(Array(Self.stepLabels.enumerated()), id: \.offset) { index, label in
                let isCompleted = index < currentIndex
                let isCurrent = index == currentIndex

                VStack(spacing: 4) {
                    Circle()
                        .fill(isCompleted || isCurrent ? Color.purple : Color.gray.opacity(0.4))
                        .frame(width: 10, height: 10)
                        .overlay {
                            if isCompleted {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 6, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                        }
                    Text(label)
                        .font(.caption2)
                        .fontWeight(isCurrent ? .semibold : .regular)
                        .foregroundStyle(isCurrent ? .white : .gray.opacity(0.6))
                }
                .frame(maxWidth: .infinity)

                if index < Self.stepLabels.count - 1 {
                    Rectangle()
                        .fill(isCompleted ? Color.purple : Color.gray.opacity(0.3))
                        .frame(height: 2)
                        .offset(y: -8)
                }
            }
        }
        .padding(.horizontal, 40)
        .padding(.bottom, 4)
    }

    // MARK: - Scenario Card

    private func scenarioCard(step: LessonStep) -> some View {
        let isReadStep = step.label == "READ"
        return VStack(alignment: .leading, spacing: 8) {
            if !isReadStep {
                Text("Scenario")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
            }
            Text(lesson.scenarioText)
                .font(isReadStep ? .body : .caption)
                .italic()
                .foregroundStyle(.white.opacity(isReadStep ? 0.9 : 0.7))
                .lineLimit(isReadStep ? nil : 3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.08))
        )
    }

    // MARK: - Question

    private func questionText(step: LessonStep) -> some View {
        Text(step.question)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Option Cards

    private func optionCards(step: LessonStep) -> some View {
        VStack(spacing: 12) {
            ForEach(Array(step.options.enumerated()), id: \.element.id) { index, option in
                LessonOptionCard(
                    index: index,
                    option: option,
                    isSelected: viewModel.selectedOptionIndex == index,
                    showingFeedback: viewModel.showFeedback,
                    onTap: { viewModel.selectOption(index) },
                    onNext: { viewModel.nextStep() }
                )
            }
        }
    }
}

// MARK: - LessonFeedbackPanel

private struct LessonFeedbackPanel: View {
    let option: LessonOption
    let onNext: () -> Void
    @State private var showFrameworks = false

    var body: some View {
        let isCorrect = option.feedback.isCorrect
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Text(option.feedback.text)
                    .font(.system(size: 14))
                    .foregroundStyle(.white.opacity(0.9))

                Spacer()

                Button { showFrameworks = true } label: {
                    Image(systemName: "questionmark.circle")
                        .font(.system(size: 18))
                        .foregroundStyle(.white.opacity(0.5))
                }
            }

            if isCorrect {
                Button(action: onNext) {
                    Text("Next \u{2192}")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Capsule().fill(Color.purple))
                }
            } else {
                Text("Try again")
                    .font(.caption)
                    .foregroundStyle(.red.opacity(0.8))
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(isCorrect ? Color.green.opacity(0.15) : Color.red.opacity(0.15))
        )
        .sheet(isPresented: $showFrameworks) {
            ResearchFrameworksSheet()
        }
    }
}

// MARK: - Research Frameworks Sheet

private struct ResearchFrameworksSheet: View {
    @Environment(\.dismiss) private var dismiss

    private let frameworks: [(icon: String, name: String, description: String, citation: String)] = [
        (
            "🤝",
            "Gottman's Bids for Connection",
            "Responding to people's emotional bids (turning toward vs. turning away) predicts relationship success.",
            "Dr. John Gottman -University of Washington"
        ),
        (
            "🧠",
            "Ekman's Facial Action Coding",
            "Reading micro-expressions and emotional states from facial cues.",
            "Dr. Paul Ekman -UCSF"
        ),
        (
            "🏷️",
            "Emotional Labeling",
            "Naming someone's emotion out loud reduces its intensity and builds trust.",
            "Dr. Matthew Lieberman -UCLA"
        ),
        (
            "🪞",
            "Mirroring and Labeling",
            "Repeating back what someone said builds rapport and makes them feel heard.",
            "Chris Voss -former FBI lead hostage negotiator"
        ),
        (
            "👂",
            "Active Listening",
            "Reflecting, paraphrasing, and asking follow-up questions to demonstrate understanding.",
            "Carl Rogers -founder of person-centered therapy"
        ),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Our answers are grounded in peer-reviewed social psychology research and proven negotiation frameworks.")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.7))
                        .padding(.bottom, 4)

                    ForEach(frameworks, id: \.name) { framework in
                        HStack(spacing: 0) {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.blue.opacity(0.6))
                                .frame(width: 3)

                            VStack(alignment: .leading, spacing: 8) {
                                HStack(spacing: 8) {
                                    Text(framework.icon)
                                        .font(.title3)
                                    Text(framework.name)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                }
                                Text(framework.description)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.8))
                                    .lineSpacing(3)
                                Text(framework.citation)
                                    .font(.caption2)
                                    .italic()
                                    .foregroundStyle(.white.opacity(0.45))
                            }
                            .padding(.leading, 12)
                            .padding(.vertical, 14)
                            .padding(.trailing, 14)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white.opacity(0.06))
                        )
                    }
                }
                .padding(20)
            }
            .background(Color.black)
            .navigationTitle("The Science Behind Social IQ")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                        .foregroundStyle(.white)
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }
}

// MARK: - LessonOptionCard

private struct LessonOptionCard: View {
    let index: Int
    let option: LessonOption
    let isSelected: Bool
    let showingFeedback: Bool
    let onTap: () -> Void
    let onNext: () -> Void

    var body: some View {
        let borderColor: Color = {
            guard isSelected, showingFeedback else { return .white.opacity(0.15) }
            return option.feedback.isCorrect ? .green : .red
        }()

        VStack(alignment: .leading, spacing: 8) {
            Text(option.label)
                .font(.subheadline)
                .foregroundStyle(.white)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)

            if isSelected, showingFeedback {
                LessonFeedbackPanel(option: option, onNext: onNext)
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white.opacity(0.06))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(borderColor, lineWidth: isSelected && showingFeedback ? 2 : 1)
        )
        .id("option-\(index)")
        .contentShape(Rectangle())
        .onTapGesture(perform: onTap)
    }
}

// MARK: - LessonCompletionView

private struct LessonCompletionView: View {
    let score: Int
    let totalSteps: Int
    let onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Text("Lesson Complete")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)

            Text("\(score) / \(totalSteps)")
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .foregroundStyle(.purple)

            Text("correct on first try")
                .font(.subheadline)
                .foregroundStyle(.gray)

            Spacer()

            Button(action: onDismiss) {
                Text("Back to Home")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.purple, .blue],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 40)
        }
    }
}

#Preview {
    NavigationStack {
        LessonView(lesson: LessonData.lesson1)
    }
}
