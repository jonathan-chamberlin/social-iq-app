//
//  OnboardingBridgeToPaywallStep.swift
//  Social IQ
//

import SwiftUI

struct OnboardingBridgeToPaywallStep: View {
    let onStartTraining: () -> Void
    let onFreeLesson: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Spacer().frame(height: 40)

            Image(systemName: "flame.fill")
                .font(.system(size: 60))
                .foregroundStyle(.orange)

            Text("Invest in yourself")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)

            Text("You've taken the first step. Your custom training plan is ready.")
                .font(.body)
                .foregroundStyle(.white.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)

            Button(action: onStartTraining) {
                Text("Start My Training")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        Capsule()
                            .fill(Color.green)
                    )
            }

            Button(action: onFreeLesson) {
                Text("Start with free lesson")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.5))
            }
        }
        .frame(maxWidth: .infinity)
    }
}
