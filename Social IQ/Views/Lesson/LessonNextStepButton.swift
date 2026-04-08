//
//  LessonNextStepButton.swift
//  Social IQ

import SwiftUI

struct LessonNextStepButton: View {
    let isVisible: Bool
    let onNext: () -> Void

    @State private var scale: CGFloat = 0
    @State private var glow = false

    private enum Timing {
        static let springResponse: Double = 0.4
        static let springDamping: Double = 0.5
        static let glowDuration: Double = 0.8
        static let glowDelay: Double = 0.4
    }

    var body: some View {
        if isVisible {
            Button {
                scale = 0
                glow = false
                onNext()
            } label: {
                Text("Next")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Capsule().fill(Theme.gold))
                    .shadow(color: glow ? Theme.gold.opacity(0.6) : .clear, radius: 8)
            }
            .scaleEffect(scale)
            .onAppear {
                withAnimation(.spring(response: Timing.springResponse, dampingFraction: Timing.springDamping)) {
                    scale = 1.0
                }
                withAnimation(.easeInOut(duration: Timing.glowDuration).repeatForever(autoreverses: true).delay(Timing.glowDelay)) {
                    glow = true
                }
            }
        }
    }
}
