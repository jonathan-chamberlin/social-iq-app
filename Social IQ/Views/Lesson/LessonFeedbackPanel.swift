//
//  LessonFeedbackPanel.swift
//  Social IQ
//

import SwiftUI

private func formatRenText(_ text: String) -> String {
    text.replacingOccurrences(of: " -", with: ",")
        .split(separator: ".", omittingEmptySubsequences: false)
        .map { segment in
            let trimmed = segment.drop(while: { $0.isWhitespace || $0.isNewline })
            guard let first = trimmed.first else { return String(segment) }
            let prefix = segment.prefix(while: { $0.isWhitespace || $0.isNewline })
            return prefix + String(first).uppercased() + trimmed.dropFirst()
        }
        .joined(separator: ".")
        .replacingOccurrences(of: ". ", with: ".\n")
}

struct LessonFeedbackPanel: View {
    let option: LessonOption
    @State private var showFrameworks = false
    @State private var showFullExplanation = false

    var body: some View {
        let isCorrect = option.feedback.isCorrect
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(formatRenText(option.feedback.renText))
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.white)
                        .lineSpacing(6)

                    if showFullExplanation {
                        Text(option.feedback.text.replacingOccurrences(of: ". ", with: ".\n"))
                            .font(.system(size: 14))
                            .foregroundStyle(.white.opacity(0.85))
                            .lineSpacing(6)
                    } else {
                        Button { showFullExplanation = true } label: {
                            Text("See more")
                                .font(.system(size: 13))
                                .foregroundStyle(.white.opacity(0.5))
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

            if !isCorrect {
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
