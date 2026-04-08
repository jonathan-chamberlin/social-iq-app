//
//  HomeLessonList.swift
//  Social IQ

import SwiftUI

struct HomeLessonList: View {
    let completedLessonIds: Set<String>
    let isProUser: Bool
    let onLessonTap: (Lesson) -> Void

    var body: some View {
        ForEach(LessonData.allLessons) { lesson in
            Button {
                onLessonTap(lesson)
            } label: {
                HomeLessonCard(
                    lesson: lesson,
                    isLocked: !isProUser && !AppConstants.freeLessonIds.contains(lesson.id),
                    isCompleted: completedLessonIds.contains(lesson.id)
                )
            }
            .buttonStyle(.plain)
        }
    }
}
