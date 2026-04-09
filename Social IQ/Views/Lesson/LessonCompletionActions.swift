//
//  LessonCompletionActions.swift
//  Social IQ

import SwiftUI

struct LessonCompletionActions: View {
    let onNextLesson: (() -> Void)?
    let onDismiss: () -> Void
    let countdownProgress: CGFloat
    let countdownActive: Bool

    private enum Timing {
        static let autoAdvanceDuration: Double = 4
    }

    var body: some View {
        VStack(spacing: 12) {
            if let onNextLesson {
                Button(action: onNextLesson) {
                    Text("Next Lesson")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background {
                            GeometryReader { geo in
                                Theme.gold.opacity(Theme.Opacity.disabled)

                                Theme.goldGradient
                                    .frame(width: geo.size.width * countdownProgress)
                                    .animation(
                                        countdownActive
                                            ? .linear(duration: Timing.autoAdvanceDuration)
                                            : .none,
                                        value: countdownProgress
                                    )
                            }
                        }
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }

            Button(action: onDismiss) {
                Text("Back to Home")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        }
        .padding(.horizontal, 32)
        .padding(.bottom, 40)
    }
}
