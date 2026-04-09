//
//  Lesson.swift
//  Social IQ
//

import Foundation

enum LessonCategory: String, Codable, Hashable {
    case workplace
    case dating
    case friendships
    case family
}

enum LessonDifficulty: String, Codable, Hashable {
    case beginner
    case intermediate
    case advanced
}

struct Lesson: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let category: LessonCategory
    let difficulty: LessonDifficulty
    let scenarioText: String
    let steps: [LessonStep]
}

struct LessonStep: Identifiable, Codable, Hashable {
    let id: String
    let label: String
    let question: String
    let options: [LessonOption]
    let correctIndex: Int
}

struct LessonOption: Identifiable, Codable, Hashable {
    let id: String
    let prefix: String
    let label: String
    let feedback: OptionFeedback
}

struct OptionFeedback: Codable, Hashable {
    let isCorrect: Bool
    let researcher: String?
    let renText: String
    let text: String
}
