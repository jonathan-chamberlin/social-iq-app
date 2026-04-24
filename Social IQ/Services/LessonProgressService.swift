//
//  LessonProgressService.swift
//  Social IQ
//

import Foundation
import Supabase
import os

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
    private static let logger = Logger(
        subsystem: "com.jonathanchamberlin.Social-IQ",
        category: "LessonProgress"
    )

    private var client: Supabase.SupabaseClient {
        SupabaseService.shared.client
    }

    /// Defensive guard added 2026-04-23 after 5 distinct phantom user_ids (not
    /// in auth.users) hit RLS 401s on build 32 over ~6 hours. Root cause is
    /// still under investigation; this blocks bad writes from reaching the DB
    /// and surfaces them as structured warnings so we can tell if the fix for
    /// the upstream bug is working.
    private func hasValidSession(for userId: String, operation: String) -> Bool {
        let sessionUserId = client.auth.currentSession?.user.id.uuidString
        if let sessionUserId, sessionUserId.caseInsensitiveCompare(userId) == .orderedSame {
            return true
        }
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "?"
        Self.logger.warning("SKIP \(operation, privacy: .public): session_user=\(sessionUserId ?? "nil", privacy: .public) payload_user=\(userId, privacy: .public) build=\(build, privacy: .public)")
        AnalyticsService.track(event: .lessonWriteSkipped, properties: [
            "operation": operation,
            "session_user_nil": sessionUserId == nil,
            "build": build,
        ])
        return false
    }

    func saveLessonProgress(userId: String, lessonId: String, score: Int) async throws {
        guard hasValidSession(for: userId, operation: "saveLessonProgress") else { return }
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
    /// Returns 0 if the session guard skips the call (see `hasValidSession`).
    func recordLessonStart(userId: String, lessonId: String) async throws -> Int {
        guard hasValidSession(for: userId, operation: "recordLessonStart") else { return 0 }
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
        guard hasValidSession(for: userId, operation: "recordAbandon") else { return }
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
        guard hasValidSession(for: userId, operation: "deleteAllProgress") else { return }
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
