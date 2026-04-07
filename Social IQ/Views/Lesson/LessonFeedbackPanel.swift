//
//  LessonFeedbackPanel.swift
//  Social IQ
//

import SwiftUI

struct LessonFeedbackPanel: View {
    let option: LessonOption
    let onNext: () -> Void
    @State private var showFrameworks = false
    @State private var showFullExplanation = false

    var body: some View {
        let isCorrect = option.feedback.isCorrect
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(option.feedback.renText)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.white)

                    if showFullExplanation {
                        Text(option.feedback.text)
                            .font(.system(size: 14))
                            .foregroundStyle(.white.opacity(0.85))
                    } else {
                        Button { showFullExplanation = true } label: {
                            Text("See more")
                                .font(.system(size: 13))
                                .foregroundStyle(.purple.opacity(0.8))
                        }
                    }
                }

                Spacer()

                Button { showFrameworks = true } label: {
                    Image(systemName: "questionmark.circle")
                        .font(.system(size: 18))
                        .foregroundStyle(.white.opacity(0.5))
                }
            }

            if isCorrect {
                Button(action: onNext) {
                    Text("Next \u{2192}")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Capsule().fill(Color.purple))
                }
            } else {
                Text("Try again")
                    .font(.caption)
                    .foregroundStyle(.red.opacity(0.8))
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(isCorrect ? Color.green.opacity(0.15) : Color.red.opacity(0.15))
        )
        .sheet(isPresented: $showFrameworks) {
            ResearchFrameworksSheet()
        }
    }
}
