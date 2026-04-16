//
//  Coachmark.swift
//  Social IQ
//

import SwiftUI

// MARK: - Coachmark ID

enum CoachmarkID: String, CaseIterable {
    case feedbackButton = "feedback_button"
}

// MARK: - Config

struct CoachmarkConfig: Identifiable {
    let id: CoachmarkID
    let message: String
    let dismissLabel: String
}

// MARK: - Registry

extension CoachmarkConfig {
    static let feedbackButton = CoachmarkConfig(
        id: .feedbackButton,
        message: "Tap here anytime to send feedback. We read every one.",
        dismissLabel: "Got it"
    )

    static func config(for id: CoachmarkID) -> CoachmarkConfig {
        switch id {
        case .feedbackButton: return .feedbackButton
        }
    }
}

// MARK: - Anchor PreferenceKey

/// Lets any view advertise itself as a coachmark target by attaching
/// `.coachmarkAnchor(.someId)`. The app root collects the published frames and
/// hands them to `CoachmarkController` so the overlay always knows the live
/// position of every potential target.
struct CoachmarkAnchorPreferenceKey: PreferenceKey {
    static let defaultValue: [CoachmarkID: CGRect] = [:]

    static func reduce(value: inout [CoachmarkID: CGRect], nextValue: () -> [CoachmarkID: CGRect]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

// MARK: - View Modifier

extension View {
    /// Mark this view as the live anchor for `id`. The view's global frame is
    /// published through `CoachmarkAnchorPreferenceKey` and consumed by the
    /// overlay, which converts to its own local space.
    func coachmarkAnchor(_ id: CoachmarkID) -> some View {
        background(
            GeometryReader { geo in
                Color.clear.preference(
                    key: CoachmarkAnchorPreferenceKey.self,
                    value: [id: geo.frame(in: .global)]
                )
            }
        )
    }
}
