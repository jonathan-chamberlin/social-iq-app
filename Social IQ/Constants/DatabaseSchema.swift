//
//  DatabaseSchema.swift
//  Social IQ
//

import Foundation

enum DatabaseSchema {
    enum LessonProgress {
        static let table = "lesson_progress"
        static let userId = "user_id"
        static let lessonId = "lesson_id"
        static let completed = "completed"
        static let attemptCount = "attempt_count"
        static let lastReachedQuestion = "last_reached_question"
        static let lastVisitedAt = "last_visited_at"
        static let upsertConflict = "user_id,lesson_id"
    }

    enum LessonProgressRPC {
        static let recordLessonStart = "record_lesson_start"
        static let paramUserId = "p_user_id"
        static let paramLessonId = "p_lesson_id"
    }

    enum UserProfiles {
        static let table = "user_profiles"
        static let id = "id"
        static let firstName = "first_name"
        static let email = "email"
        static let onboardingCompleted = "onboarding_completed"
    }

    enum UserMetadata {
        static let fullName = "full_name"
    }
}
