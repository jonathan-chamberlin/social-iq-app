//
//  LessonProgressService.swift
//  Social IQ
//

import Foundation
import Supabase

enum LessonProgressError: LocalizedError {
    case invalidUserId(String)

    var errorDescription: String? {
        switch self {
        case .invalidUserId(let id):
            "Invalid user ID: \(id)"
        }
    }
}

struct LessonProgressService {
    private var client: Supabase.SupabaseClient {
        SupabaseService.shared.client
    }

    func saveLessonProgress(userId: String, lessonId: String, score: Int) async throws {
        guard let userUUID = UUID(uuidString: userId) else {
            throw LessonProgressError.invalidUserId(userId)
        }
        let row = LessonProgress(
            id: UUID(),
            userId: userUUID,
            lessonId: lessonId,
            completed: true,
            score: score,
            completedAt: Date()
        )
        try await client.from(DatabaseSchema.LessonProgress.table)
            .upsert(row, onConflict: DatabaseSchema.LessonProgress.upsertConflict)
            .execute()
    }

    /// Increments attempt_count atomically on lesson open and returns the new value.
    /// First visit returns 1; each replay returns the next integer.
    func recordLessonStart(userId: String, lessonId: String) async throws -> Int {
        guard let userUUID = UUID(uuidString: userId) else {
            throw LessonProgressError.invalidUserId(userId)
        }
        struct Params: Encodable {
            let p_user_id: UUID
            let p_lesson_id: String
        }
        let attemptCount: Int = try await client.rpc(
            DatabaseSchema.LessonProgressRPC.recordLessonStart,
            params: Params(p_user_id: userUUID, p_lesson_id: lessonId)
        ).execute().value
        return attemptCount
    }

    /// Writes the furthest question (1-based) the user reached before exiting mid-lesson.
    func recordAbandon(userId: String, lessonId: String, lastReachedQuestion: Int) async throws {
        struct Update: Encodable {
            let last_reached_question: Int
        }
        try await client.from(DatabaseSchema.LessonProgress.table)
            .update(Update(last_reached_question: lastReachedQuestion))
            .eq(DatabaseSchema.LessonProgress.userId, value: userId)
            .eq(DatabaseSchema.LessonProgress.lessonId, value: lessonId)
            .execute()
    }

    func deleteAllProgress(userId: String) async throws {
        try await client.from(DatabaseSchema.LessonProgress.table)
            .delete()
            .eq(DatabaseSchema.LessonProgress.userId, value: userId)
            .execute()
    }

    func fetchCompletedLessons(userId: String) async throws -> [LessonProgress] {
        try await client.from(DatabaseSchema.LessonProgress.table)
            .select()
            .eq(DatabaseSchema.LessonProgress.userId, value: userId)
            .eq(DatabaseSchema.LessonProgress.completed, value: true)
            .execute()
            .value
    }
}
