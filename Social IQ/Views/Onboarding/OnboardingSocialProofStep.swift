//
//  OnboardingSocialProofStep.swift
//  Social IQ
//

import SwiftUI

struct OnboardingSocialProofStep: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What others are saying")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top, 20)

            testimonialCard(
                name: "Jake",
                duration: "2 weeks in",
                text: "I used to dread networking events. After 2 weeks, I actually look forward to them. My conversations feel natural now."
            )
            testimonialCard(
                name: "Emma",
                duration: "1 month in",
                text: "It's like Duolingo but I actually see results every day."
            )
            testimonialCard(
                name: "Marcus",
                duration: "3 weeks in",
                text: "I wish I started using this sooner."
            )
        }
    }

    private func testimonialCard(name: String, duration: String, text: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 2) {
                ForEach(0..<5, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundStyle(.yellow)
                }
            }

            Text(text)
                .font(.subheadline)
                .foregroundStyle(.white)
                .lineSpacing(4)

            HStack(spacing: 6) {
                Text(name)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Text("·")
                    .foregroundStyle(.white.opacity(Theme.Opacity.secondary))
                Text(duration)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(Theme.Opacity.secondary))
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.11, green: 0.11, blue: 0.118))
        )
    }
}
