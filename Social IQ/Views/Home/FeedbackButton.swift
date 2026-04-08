//
//  FeedbackButton.swift
//  Social IQ
//

import SwiftUI

struct FeedbackButton: View {
    let userId: String?

    private static let feedbackFormBaseURL = "https://docs.google.com/forms/d/1JE2L8trw-RFpBGpzPmtHm5MjfxLxbC8lpLjAq6FkVWU/viewform?usp=pp_url"
    private static let feedbackUserEntryField = "&entry.1584329496="

    private var feedbackURL: URL? {
        let userParam = userId.map { "\(Self.feedbackUserEntryField)\($0)" } ?? ""
        return URL(string: Self.feedbackFormBaseURL + userParam)
    }

    var body: some View {
        Button {
            guard let feedbackURL else { return }
            UIApplication.shared.open(feedbackURL)
        } label: {
            Image(systemName: "bubble.left.fill")
                .font(.system(size: 20))
                .foregroundStyle(.white)
                .frame(width: 48, height: 48)
                .background(
                    Circle().fill(Theme.goldGradient)
                )
                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
        }
    }
}
