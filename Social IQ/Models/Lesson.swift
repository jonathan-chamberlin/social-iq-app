//
//  Lesson.swift
//  Social IQ
//

import Foundation

struct Lesson: Identifiable, Codable {
    let id: String
    let title: String
    let category: String
    let difficulty: String
    let scenarioText: String
    let steps: [LessonStep]
}

struct LessonStep: Identifiable, Codable {
    let id: String
    let label: String
    let question: String
    let options: [LessonOption]
    let correctIndex: Int
}

struct LessonOption: Identifiable, Codable {
    let id: String
    let prefix: String
    let label: String
    let feedback: OptionFeedback
}

struct OptionFeedback: Codable {
    let isCorrect: Bool
    let text: String
}
