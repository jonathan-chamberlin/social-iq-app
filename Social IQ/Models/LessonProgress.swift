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
    let attemptCount: Int?
    let lastReachedQuestion: Int?
    let lastVisitedAt: Date?

    init(
        id: UUID,
        userId: UUID,
        lessonId: String,
        completed: Bool,
        score: Int,
        completedAt: Date?,
        attemptCount: Int? = nil,
        lastReachedQuestion: Int? = nil,
        lastVisitedAt: Date? = nil
    ) {
        self.id = id
        self.userId = userId
        self.lessonId = lessonId
        self.completed = completed
        self.score = score
        self.completedAt = completedAt
        self.attemptCount = attemptCount
        self.lastReachedQuestion = lastReachedQuestion
        self.lastVisitedAt = lastVisitedAt
    }

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case lessonId = "lesson_id"
        case completed
        case score
        case completedAt = "completed_at"
        case attemptCount = "attempt_count"
        case lastReachedQuestion = "last_reached_question"
        case lastVisitedAt = "last_visited_at"
    }
}
