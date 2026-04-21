//
//  LessonViewModel.swift
//  Social IQ
//

import Foundation

@Observable
final class LessonViewModel {
    var currentLesson: Lesson?
    var currentStepIndex: Int = 0
    var selectedOptionIndex: Int?
    var showFeedback: Bool = false
    var answers: [Int] = []
    var isComplete: Bool = false
    var saveError: String?
    var questionStartedAt: Date = .now
    /// Flips true when the user advances FROM question 1 to question 2.
    /// Consumed by `LessonView` to trigger the feedback-button coachmark.
    var hasAnsweredFirstQuestion: Bool = false

    private let progressService = LessonProgressService()

    var currentStep: LessonStep? {
        guard let lesson = currentLesson,
              currentStepIndex < lesson.steps.count else { return nil }
        return lesson.steps[currentStepIndex]
    }

    var score: Int {
        guard let lesson = currentLesson else { return 0 }
        return zip(answers, lesson.steps).reduce(0) { total, pair in
            total + (pair.0 == pair.1.correctIndex ? 1 : 0)
        }
    }

    var isCorrectSelection: Bool {
        guard let step = currentStep,
              let selected = selectedOptionIndex else { return false }
        return selected == step.correctIndex
    }

    func startLesson(_ lesson: Lesson) {
        currentLesson = lesson
        currentStepIndex = 0
        selectedOptionIndex = nil
        showFeedback = false
        answers = []
        isComplete = false
        questionStartedAt = .now
        hasAnsweredFirstQuestion = false
    }

    func selectOption(_ index: Int) {
        selectedOptionIndex = index
        showFeedback = true
    }

    func nextStep() {
        guard let lesson = currentLesson,
              let selected = selectedOptionIndex else { return }
        let wasFirstQuestion = currentStepIndex == 0
        answers.append(selected)
        if currentStepIndex + 1 < lesson.steps.count {
            HapticService.light()
            currentStepIndex += 1
            selectedOptionIndex = nil
            showFeedback = false
            questionStartedAt = .now
            if wasFirstQuestion {
                hasAnsweredFirstQuestion = true
            }
        } else {
            isComplete = true
        }
    }

    func saveProgress(userId: String) async {
        guard let lesson = currentLesson else { return }
        do {
            try await progressService.saveLessonProgress(
                userId: userId,
                lessonId: lesson.id,
                score: score
            )
        } catch {
            saveError = error.localizedDescription
        }
    }

    // MARK: - Analytics

    func trackLessonStarted(isReplay: Bool) {
        guard let lesson = currentLesson else { return }
        if isReplay {
            AnalyticsService.track(event: .lessonReplayed, properties: ["lesson_id": lesson.id])
        }
        AnalyticsService.track(event: .lessonStarted, properties: ["lesson_id": lesson.id])
    }

    func trackQuestionAnswered(selectedIndex: Int) {
        guard let step = currentStep, let lesson = currentLesson else { return }
        let timeToAnswer = Int(Date().timeIntervalSince(questionStartedAt))
        AnalyticsService.track(event: .questionAnswered, properties: [
            "lesson_id": lesson.id,
            "question_number": currentStepIndex + 1,
            "question_type": step.label,
            "answer_index": selectedIndex,
            "is_correct": step.options[selectedIndex].feedback.isCorrect,
            "time_to_answer_seconds": timeToAnswer,
        ])
    }

    func trackLessonAbandoned() {
        guard let lesson = currentLesson else { return }
        AnalyticsService.track(event: .lessonAbandoned, properties: [
            "lesson_id": lesson.id,
            "question_number": currentStepIndex + 1,
            "question_type": currentStep?.label ?? "unknown",
        ])
    }

    func trackLessonCompleted() {
        guard let lesson = currentLesson else { return }
        AnalyticsService.track(event: .lessonCompleted, properties: ["lesson_id": lesson.id])
    }
}
