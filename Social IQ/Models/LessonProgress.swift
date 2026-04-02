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
}
