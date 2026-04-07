//
//  LessonOptionCard.swift
//  Social IQ
//

import SwiftUI
import UIKit

struct LessonOptionCard: View {
    let index: Int
    let option: LessonOption
    let isSelected: Bool
    let showingFeedback: Bool
    let onTap: () -> Void
    let onNext: () -> Void
    @State private var hasPlayedSound = false

    var body: some View {
        let borderColor: Color = {
            guard isSelected, showingFeedback else { return .white.opacity(0.15) }
            return option.feedback.isCorrect ? .green : .red
        }()

        VStack(alignment: .leading, spacing: 8) {
            Text(option.label)
                .font(.subheadline)
                .foregroundStyle(.white)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)

            if isSelected, showingFeedback {
                LessonFeedbackPanel(option: option)
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white.opacity(0.06))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(borderColor, lineWidth: isSelected && showingFeedback ? 2 : 1)
        )
        .id("option-\(index)")
        .contentShape(Rectangle())
        .onTapGesture {
            if option.feedback.isCorrect {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            }
            if !hasPlayedSound {
                SoundPlayer.play(option.feedback.isCorrect ? .correctAnswer : .wrongAnswer)
                hasPlayedSound = true
            }
            onTap()
        }
    }
}
