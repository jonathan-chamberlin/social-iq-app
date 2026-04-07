//
//  LessonCompletionView.swift
//  Social IQ

import SwiftUI
import UIKit

struct LessonCompletionView: View {
    let lessonId: String
    let score: Int
    let totalSteps: Int
    let onNextLesson: (() -> Void)?
    let onDismiss: () -> Void

    // MARK: - Animation State

    @State private var displayedScore = 0
    @State private var showScoreGlow = false
    @State private var showPercentile = false
    @State private var percentileScale: CGFloat = 1.8
    @State private var percentileOpacity: Double = 0
    @State private var countdownSeconds = 5
    @State private var countdownActive = false

    // MARK: - Computed

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

            // MARK: - Animated Score

            Text("\(displayedScore) / \(totalSteps)")
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .foregroundStyle(Theme.gold)
                .shadow(
                    color: showScoreGlow ? Theme.gold.opacity(0.6) : .clear,
                    radius: showScoreGlow ? 16 : 0
                )

            Text("correct on first try")
                .font(.subheadline)
                .foregroundStyle(.gray)

            // MARK: - Percentile Flash

            VStack(spacing: 6) {
                Text("\(completionCount.formatted()) people completed this lesson")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))

                Text("You finished faster than \(percentile)% of them")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Theme.goldLight)
                    .scaleEffect(percentileScale)
                    .opacity(percentileOpacity)
            }
            .padding(.top, 4)

            Spacer()

            // MARK: - Actions

            VStack(spacing: 12) {
                if let onNextLesson {
                    Button(action: onNextLesson) {
                        HStack {
                            Text(countdownActive
                                ? "Next Lesson (\(countdownSeconds))"
                                : "Next Lesson")
                                .font(.headline)
                        }
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

                Button(action: {
                    countdownActive = false
                    onDismiss()
                }) {
                    Text("Back to Home")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 40)
        }
        .task(id: countdownActive) {
            guard countdownActive, let onNextLesson else { return }
            while countdownSeconds > 0 {
                try? await Task.sleep(for: .seconds(1))
                guard countdownActive else { return }
                countdownSeconds -= 1
            }
            countdownActive = false
            onNextLesson()
        }
        .onAppear {
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            SoundPlayer.play(.lessonComplete)
            startAnimations()
        }
    }

    // MARK: - Animation Sequence

    private func startAnimations() {
        // 1. Count up the score
        for i in 1...max(score, 1) {
            let delay = Double(i) * 0.15
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                displayedScore = min(i, score)
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
        }

        // 2. Gold glow after count-up finishes
        let countUpDuration = Double(max(score, 1)) * 0.15 + 0.1
        DispatchQueue.main.asyncAfter(deadline: .now() + countUpDuration) {
            withAnimation(.easeOut(duration: 0.4)) {
                showScoreGlow = true
            }
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        }

        // 3. Percentile flash - scale down + fade in
        DispatchQueue.main.asyncAfter(deadline: .now() + countUpDuration + 0.5) {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                percentileScale = 1.0
                percentileOpacity = 1.0
            }
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        }

        // 4. Start auto-advance countdown (only if next lesson exists)
        if onNextLesson != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + countUpDuration + 1.2) {
                countdownActive = true
            }
        }
    }
}
