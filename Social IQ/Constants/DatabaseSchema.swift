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
        static let upsertConflict = "user_id,lesson_id"
    }

    enum UserProfiles {
        static let table = "user_profiles"
        static let id = "id"
        static let onboardingCompleted = "onboarding_completed"
    }

    enum UserMetadata {
        static let fullName = "full_name"
    }
}
