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

#Preview {
    NavigationStack {
        LessonView(lesson: LessonData.lesson1)
    }
}
