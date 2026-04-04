//
//  OnboardingRatingPromptStep.swift
//  Social IQ
//

import StoreKit
import SwiftUI

struct OnboardingRatingPromptStep: View {
    var body: some View {
        VStack(spacing: 24) {
            Spacer().frame(height: 40)

            Image(systemName: "star.bubble")
                .font(.system(size: 60))
                .foregroundStyle(.yellow.opacity(0.8))

            Text("Enjoying Social IQ?")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)

            Text("A quick rating helps other people discover Social IQ")
                .font(.body)
                .foregroundStyle(.white.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            requestAppReview()
        }
    }

    private func requestAppReview() {
        #if !DEBUG
        if let scene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
        #endif
    }
}
