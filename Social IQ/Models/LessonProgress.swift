//
//  LessonProgress.swift
//  Social IQ
//

import Foundation

struct LessonProgress: Codable, Identifiable {
    let id: UUID
    let userId: UUID
    let lessonId: String
    let completed: Bool
    let score: Int
    let completedAt: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case lessonId = "lesson_id"
        case completed
        case score
        case completedAt = "completed_at"
    }
}
