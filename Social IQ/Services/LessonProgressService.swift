//
//  LessonProgressService.swift
//  Social IQ
//

import Foundation
import Supabase

struct LessonProgressService {
    private var client: Supabase.SupabaseClient {
        SupabaseService.shared.client
    }

    func saveLessonProgress(userId: String, lessonId: String, score: Int) async throws {
        let row = LessonProgress(
            id: UUID(),
            userId: UUID(uuidString: userId)!,
            lessonId: lessonId,
            completed: true,
            score: score,
            completedAt: Date()
        )
        try await client.from("lesson_progress")
            .upsert(row, onConflict: "user_id,lesson_id")
            .execute()
    }

    func fetchCompletedLessons(userId: String) async throws -> [LessonProgress] {
        try await client.from("lesson_progress")
            .select()
            .eq("user_id", value: userId)
            .eq("completed", value: true)
            .execute()
            .value
    }
}
