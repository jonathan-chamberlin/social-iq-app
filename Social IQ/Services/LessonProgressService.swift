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
