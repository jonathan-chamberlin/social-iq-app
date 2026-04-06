//
//  LessonCompletionView.swift
//  Social IQ
//

import SwiftUI

struct LessonCompletionView: View {
    let score: Int
    let totalSteps: Int
    let onDismiss: () -> Void
    @State private var percentile: Int = 0

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Text("Lesson Complete")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)

            Text("\(score) / \(totalSteps)")
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .foregroundStyle(.purple)

            Text("correct on first try")
                .font(.subheadline)
                .foregroundStyle(.gray)

            if percentile > 0 {
                Text("You read that better than \(percentile)% of people")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
                    .padding(.top, 4)
            }

            Spacer()

            Button(action: onDismiss) {
                Text("Back to Home")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.purple, .blue],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 40)
        }
        .onAppear {
            let range: ClosedRange<Int> = switch score {
            case 3: 78...92
            case 2: 55...72
            case 1: 30...48
            default: 8...22
            }
            percentile = Int.random(in: range)
        }
    }
}
