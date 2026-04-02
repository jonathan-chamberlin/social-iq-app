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
    }

    func selectOption(_ index: Int) {
        selectedOptionIndex = index
        showFeedback = true
    }

    func nextStep() {
        guard let lesson = currentLesson,
              let selected = selectedOptionIndex else { return }
        answers.append(selected)
        if currentStepIndex + 1 < lesson.steps.count {
            currentStepIndex += 1
            selectedOptionIndex = nil
            showFeedback = false
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
}
