//
//  LessonCompletionView.swift
//  Social IQ

import SwiftUI

struct LessonCompletionView: View {
    private enum Timing {
        static let scoreTickInterval: Double = 0.15
        static let glowFadeDuration: Double = 0.4
        static let percentileDelay: Double = 0.5
        static let countdownStartDelay: Double = 1.2
        static let autoAdvanceDuration: Double = 4
        static let percentileSpringResponse: Double = 0.4
        static let percentileSpringDamping: Double = 0.6
    }

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
    @State private var countdownProgress: CGFloat = 0
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
                        Text("Next Lesson")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background {
                                GeometryReader { geo in
                                    // Dim base
                                    Theme.gold.opacity(0.3)

                                    // Gold fill sweeping left to right
                                    LinearGradient(
                                        colors: [Theme.gold, Theme.goldLight],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
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

                Button(action: {
                    countdownActive = false
                    countdownProgress = 0
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
            guard countdownActive, onNextLesson != nil else { return }
            // Kick off the fill animation on the next frame
            countdownProgress = 1.0
            // Wait for the fill to complete
            try? await Task.sleep(for: .seconds(Timing.autoAdvanceDuration))
            guard countdownActive else { return }
            countdownActive = false
            onNextLesson?()
        }
        .onAppear {
            HapticService.success()
            SoundPlayer.play(.lessonComplete)
            startAnimations()
        }
    }

    // MARK: - Animation Sequence

    private func startAnimations() {
        // 1. Count up the score
        for i in 1...max(score, 1) {
            let delay = Double(i) * Timing.scoreTickInterval
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                displayedScore = min(i, score)
                HapticService.light()
            }
        }

        // 2. Gold glow after count-up finishes
        let countUpDuration = Double(max(score, 1)) * Timing.scoreTickInterval + 0.1
        DispatchQueue.main.asyncAfter(deadline: .now() + countUpDuration) {
            withAnimation(.easeOut(duration: Timing.glowFadeDuration)) {
                showScoreGlow = true
            }
            HapticService.medium()
        }

        // 3. Percentile flash - scale down + fade in
        DispatchQueue.main.asyncAfter(deadline: .now() + countUpDuration + Timing.percentileDelay) {
            withAnimation(.spring(response: Timing.percentileSpringResponse, dampingFraction: Timing.percentileSpringDamping)) {
                percentileScale = 1.0
                percentileOpacity = 1.0
            }
            HapticService.heavy()
        }

        // 4. Start auto-advance countdown (only if next lesson exists)
        if onNextLesson != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + countUpDuration + Timing.countdownStartDelay) {
                countdownActive = true
            }
        }
    }
}
