//
//  FeedbackButton.swift
//  Social IQ
//

import SwiftUI

struct FeedbackButton: View {
    let userId: String?

    private var feedbackURL: URL {
        let baseURL = "https://docs.google.com/forms/d/1JE2L8trw-RFpBGpzPmtHm5MjfxLxbC8lpLjAq6FkVWU/viewform?usp=pp_url"
        let userParam = userId.map { "&entry.1584329496=\($0)" } ?? ""
        return URL(string: baseURL + userParam)!
    }

    var body: some View {
        Button {
            UIApplication.shared.open(feedbackURL)
        } label: {
            Image(systemName: "bubble.left.fill")
                .font(.system(size: 20))
                .foregroundStyle(.white)
                .frame(width: 48, height: 48)
                .background(
                    Circle().fill(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                )
                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
        }
    }
}
