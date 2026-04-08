//
//  HomeLessonCard.swift
//  Social IQ

import SwiftUI

struct HomeLessonCard: View {
    let lesson: Lesson
    let isLocked: Bool
    let isCompleted: Bool

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(lesson.title)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)

                HStack(spacing: 8) {
                    tag(lesson.category.rawValue, color: Theme.gold)
                    tag(lesson.difficulty.rawValue, color: .blue)
                }
            }

            Spacer()

            if isLocked {
                Text("PRO")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule().fill(Theme.goldGradient)
                    )
            } else if isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.green)
                    .font(.title2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .cardBackground()
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }

    private func tag(_ text: String, color: Color) -> some View {
        Text(text.capitalized)
            .font(.caption2)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Capsule().fill(color.opacity(0.4)))
    }
}
