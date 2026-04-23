//
//  LessonData.swift
//  Social IQ
//

import Foundation

enum LessonData {
    // Display order: Party → Mia Date → Raves → Parent → Work → Sibling → Climbing Flirt
    // Free: lesson-3, lesson-2, lesson-7, lesson-4 (see AppConstants.freeLessonIds). Rest are Pro.
    static var allLessons: [Lesson] { [lesson3, lesson2, lesson7, lesson4, lesson1, lesson5, lesson6] }
}
