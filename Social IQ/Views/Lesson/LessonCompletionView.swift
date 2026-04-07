//
//  LessonCompletionView.swift
//  Social IQ
//

import SwiftUI
import UIKit

struct LessonCompletionView: View {
    let lessonId: String
    let score: Int
    let totalSteps: Int
    let onNextLesson: (() -> Void)?
    let onDismiss: () -> Void

    private var completionCount: Int {
        AppConstants.lessonCompletionCounts[lessonId] ?? 0
    }

    private var percentile: Int {
        AppConstants.lessonPercentiles[lessonId] ?? 85
    }

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Text("Lesson Complete")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)

            Text("\(score) / \(totalSteps)")
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .foregroundStyle(Theme.gold)

            Text("correct on first try")
                .font(.subheadline)
                .foregroundStyle(.gray)

            VStack(spacing: 6) {
                Text("\(completionCount.formatted()) people completed this lesson")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))
                Text("You finished faster than \(percentile)% of them")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
            }
            .padding(.top, 4)

            Spacer()

            VStack(spacing: 12) {
                if let onNextLesson {
                    Button(action: onNextLesson) {
                        Text("Next Lesson")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [Theme.gold, Theme.goldLight],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
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
        .onAppear {
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            SoundPlayer.play(.lessonComplete)
        }
    }
}
