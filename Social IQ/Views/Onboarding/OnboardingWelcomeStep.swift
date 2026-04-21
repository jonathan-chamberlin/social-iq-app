//
//  OnboardingWelcomeStep.swift
//  Social IQ
//

import SwiftUI

struct OnboardingWelcomeStep: View {
    let onGetStarted: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 60)

            Image("LaunchLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 140)
                .clipShape(.rect(cornerRadius: 32))
                .shadow(color: Theme.gold.opacity(Theme.Opacity.subtle), radius: 24, x: 0, y: 0)

            Spacer(minLength: 32)

            Text("Social IQ")
                .font(.system(size: 44, weight: .bold))
                .foregroundStyle(Theme.goldGradient)

            Text("Train the social instincts nobody teaches you.")
                .font(.title3)
                .foregroundStyle(.white.opacity(Theme.Opacity.secondary))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .padding(.top, 16)

            Spacer(minLength: 40)

            Button {
                HapticService.medium()
                onGetStarted()
            } label: {
                Text("Get Started")
                    .font(.headline)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(
                        Capsule()
                            .fill(Theme.goldGradient)
                    )
            }
            .padding(.bottom, 12)
        }
        .frame(maxWidth: .infinity)
        .containerRelativeFrame(.vertical) { length, _ in length }
    }
}

#Preview {
    OnboardingWelcomeStep(onGetStarted: {})
        .screenBackground()
        .preferredColorScheme(.dark)
}
