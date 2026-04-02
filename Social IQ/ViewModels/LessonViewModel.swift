//
//  LessonViewModel.swift
//  Social IQ
//

import Foundation

@Observable
final class LessonViewModel {
    var lessons: [LessonProgress] = []

    func loadLessons() async {
        // TODO: Fetch lessons from Supabase
    }
}
