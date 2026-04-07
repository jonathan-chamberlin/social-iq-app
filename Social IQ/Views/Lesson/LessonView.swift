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
    @State private var activeLesson: Lesson?
    @State private var showOtherAnswers = false
    @State private var nextButtonScale: CGFloat = 0
    @State private var nextButtonGlow = false
    @Environment(\.dismiss) private var dismiss

    private static let stepLabels = ["READ", "THINK", "SPEAK"]

    private var displayedLesson: Lesson { activeLesson ?? lesson }

    private var nextLesson: Lesson? {
        guard let currentIndex = LessonData.allLessons.firstIndex(where: { $0.id == displayedLesson.id }),
              currentIndex + 1 < LessonData.allLessons.count else { return nil }
        return LessonData.allLessons[currentIndex + 1]
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if viewModel.isComplete {
                LessonCompletionView(
                    lessonId: displayedLesson.id,
                    score: viewModel.score,
                    totalSteps: displayedLesson.steps.count,
                    onNextLesson: nextLesson.map { next in
                        {
                            activeLesson = next
                            viewModel.startLesson(next)
                            AnalyticsService.track(event: .lessonStarted, properties: ["lesson_id": next.id])
                        }
                    },
                    onDismiss: { dismiss() }
                )
            } else if let step = viewModel.currentStep {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 20) {
                            Text(displayedLesson.title)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white.opacity(0.5))
                                .frame(maxWidth: .infinity, alignment: .leading)

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
                                    "lesson_id": displayedLesson.id,
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if showOtherAnswers {
                    Button {
                        showOtherAnswers = false
                        nextButtonScale = 0
                        nextButtonGlow = false
                        viewModel.nextStep()
                    } label: {
                        Text("Next")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Capsule().fill(Theme.gold))
                            .shadow(color: nextButtonGlow ? Theme.gold.opacity(0.6) : .clear, radius: 8)
                    }
                    .scaleEffect(nextButtonScale)
                    .onAppear {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                            nextButtonScale = 1.0
                        }
                        withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true).delay(0.4)) {
                            nextButtonGlow = true
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.startLesson(lesson)
            AnalyticsService.track(event: .lessonStarted, properties: ["lesson_id": lesson.id])
        }
        .onChange(of: viewModel.isComplete) { _, complete in
            if complete, let userId {
                AnalyticsService.track(event: .lessonCompleted, properties: ["lesson_id": displayedLesson.id])
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
                        .fill(isCompleted || isCurrent ? Theme.gold : Color.gray.opacity(0.4))
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
                        .fill(isCompleted ? Theme.gold : Color.gray.opacity(0.3))
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
            Text(displayedLesson.scenarioText.replacingOccurrences(of: ". ", with: ".\n"))
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
                let shouldShowFeedback: Bool = {
                    if viewModel.selectedOptionIndex == index && viewModel.showFeedback {
                        return true
                    }
                    if !option.feedback.isCorrect && showOtherAnswers {
                        return true
                    }
                    return false
                }()

                LessonOptionCard(
                    index: index,
                    option: option,
                    isSelected: viewModel.selectedOptionIndex == index,
                    showingFeedback: shouldShowFeedback,
                    onTap: { viewModel.selectOption(index) },
                    onNext: {}
                )
            }

            if viewModel.isCorrectSelection && viewModel.showFeedback && !showOtherAnswers {
                Button {
                    withAnimation { showOtherAnswers = true }
                } label: {
                    Text("See why the other answers were wrong")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [Theme.gold, Theme.goldLight],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.top, 8)
            }
        }
    }
}

#Preview {
    NavigationStack {
        LessonView(lesson: LessonData.lesson1)
    }
}
