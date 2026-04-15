//
//  LessonView.swift
//  Social IQ
//

import SwiftUI

struct LessonView: View {
    var lesson: Lesson
    var userId: String?
    var isReplay: Bool = false
    var onComplete: (() -> Void)?
    @State private var viewModel = LessonViewModel()
    @State private var activeLesson: Lesson?
    @State private var showOtherAnswers = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.scenePhase) private var scenePhase

    private var displayedLesson: Lesson { activeLesson ?? lesson }

    private var nextLesson: Lesson? {
        guard let currentIndex = LessonData.allLessons.firstIndex(where: { $0.id == displayedLesson.id }),
              currentIndex + 1 < LessonData.allLessons.count else { return nil }
        return LessonData.allLessons[currentIndex + 1]
    }

    var body: some View {
        ZStack {
            if viewModel.isComplete {
                LessonCompletionView(
                    lessonId: displayedLesson.id,
                    score: viewModel.score,
                    totalSteps: displayedLesson.steps.count,
                    researchers: uniqueResearchers(for: displayedLesson),
                    onNextLesson: nextLesson.map { next in
                        { advanceToLesson(next) }
                    },
                    onDismiss: { dismiss() }
                )
            } else if let step = viewModel.currentStep {
                LessonAnswerSection(
                    lessonTitle: displayedLesson.title,
                    step: step,
                    scenarioText: displayedLesson.scenarioText,
                    selectedOptionIndex: viewModel.selectedOptionIndex,
                    showFeedback: viewModel.showFeedback,
                    isCorrectSelection: viewModel.isCorrectSelection,
                    showOtherAnswers: showOtherAnswers,
                    onSelectOption: { viewModel.selectOption($0) },
                    onTrackAnswer: { selected in
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
                )
            }
        }
        .screenBackground()
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if showOtherAnswers {
                    LessonNextStepButton(isVisible: true) {
                        showOtherAnswers = false
                        viewModel.nextStep()
                    }
                } else if viewModel.isCorrectSelection && viewModel.showFeedback {
                    LessonExplainButton {
                        withAnimation { showOtherAnswers = true }
                    }
                }
            }
        }
        .onAppear {
            viewModel.startLesson(lesson)
            if isReplay {
                AnalyticsService.track(event: .lessonReplayed, properties: ["lesson_id": lesson.id])
            }
            AnalyticsService.track(event: .lessonStarted, properties: ["lesson_id": lesson.id])
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .background, !viewModel.isComplete {
                AnalyticsService.track(event: .lessonAbandoned, properties: [
                    "lesson_id": displayedLesson.id,
                    "question_number": viewModel.currentStepIndex + 1,
                    "question_type": viewModel.currentStep?.label ?? "unknown",
                ])
            }
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

    // MARK: - Helpers

    private func uniqueResearchers(for lesson: Lesson) -> [String] {
        var seen = Set<String>()
        return lesson.steps
            .flatMap { $0.options }
            .compactMap { $0.feedback.researcher }
            .filter { seen.insert($0).inserted }
    }

    // MARK: - Next Lesson

    private func advanceToLesson(_ next: Lesson) {
        if AppConstants.freeLessonIds.contains(next.id) || SuperwallService.isSubscribed {
            startNextLesson(next)
        } else {
            SuperwallService.presentPaywallWithHandler(placement: .lessonLocked) {
                startNextLesson(next)
            }
        }
    }

    private func startNextLesson(_ next: Lesson) {
        activeLesson = next
        viewModel.startLesson(next)
        AnalyticsService.track(event: .lessonStarted, properties: ["lesson_id": next.id])
    }
}

#Preview {
    NavigationStack {
        LessonView(lesson: LessonData.lesson1)
    }
}

// MARK: - Explain Button

private struct LessonExplainButton: View {
    let onTap: () -> Void

    @State private var scale: CGFloat = 0
    @State private var pulse = false

    private enum Timing {
        static let springResponse: Double = 0.4
        static let springDamping: Double = 0.5
        static let pulseDuration: Double = 0.9
        static let pulseDelay: Double = 0.3
    }

    var body: some View {
        Button(action: onTap) {
            Text("Explain")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(.black)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Capsule().fill(.white))
                .shadow(color: .white.opacity(pulse ? 0.9 : 0.0), radius: pulse ? 12 : 0)
        }
        .accessibilityLabel("See why the other answers were wrong")
        .scaleEffect(scale * (pulse ? 1.08 : 1.0))
        .onAppear {
            withAnimation(.spring(response: Timing.springResponse, dampingFraction: Timing.springDamping)) {
                scale = 1.0
            }
            withAnimation(.easeInOut(duration: Timing.pulseDuration).repeatForever(autoreverses: true).delay(Timing.pulseDelay)) {
                pulse = true
            }
        }
    }
}
