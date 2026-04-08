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

            LessonCompletionScoreCard(
                displayedScore: displayedScore,
                totalSteps: totalSteps,
                showScoreGlow: showScoreGlow,
                completionCount: completionCount,
                percentile: percentile,
                percentileScale: percentileScale,
                percentileOpacity: percentileOpacity
            )

            Spacer()

            LessonCompletionActions(
                onNextLesson: onNextLesson,
                onDismiss: {
                    countdownActive = false
                    countdownProgress = 0
                    onDismiss()
                },
                countdownProgress: countdownProgress,
                countdownActive: countdownActive
            )
        }
        .task(id: countdownActive) {
            guard countdownActive, onNextLesson != nil else { return }
            countdownProgress = 1.0
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
        Task {
            for i in 1...max(score, 1) {
                try? await Task.sleep(for: .seconds(Timing.scoreTickInterval))
                displayedScore = min(i, score)
                HapticService.light()
            }

            try? await Task.sleep(for: .seconds(0.1))
            withAnimation(.easeOut(duration: Timing.glowFadeDuration)) {
                showScoreGlow = true
            }
            HapticService.medium()

            try? await Task.sleep(for: .seconds(Timing.percentileDelay))
            withAnimation(.spring(response: Timing.percentileSpringResponse, dampingFraction: Timing.percentileSpringDamping)) {
                percentileScale = 1.0
                percentileOpacity = 1.0
            }
            HapticService.heavy()

            if onNextLesson != nil {
                try? await Task.sleep(for: .seconds(Timing.countdownStartDelay - Timing.percentileDelay))
                countdownActive = true
            }
        }
    }
}
