//
//  CoachmarkController.swift
//  Social IQ
//
//  Global coordinator for one-shot tutorial overlays. Tracks "seen" status
//  in UserDefaults so each coachmark fires at most once per device.
//

import Foundation
import Observation
import SwiftUI

@Observable
final class CoachmarkController {
    static let shared = CoachmarkController()

    private(set) var visible: CoachmarkConfig?
    /// Live frames of registered anchor views, in the app root's `coachmark`
    /// coordinate space. Published by `.coachmarkAnchor(_:)` modifiers and read
    /// by `CoachmarkOverlay` to position the spotlight.
    private(set) var anchorFrames: [CoachmarkID: CGRect] = [:]
    private var shownAt: Date?

    private init() {}

    // MARK: - Anchor Registration

    func registerAnchor(_ id: CoachmarkID, frame: CGRect) {
        anchorFrames[id] = frame
    }

    func mergeAnchors(_ frames: [CoachmarkID: CGRect]) {
        for (id, frame) in frames { anchorFrames[id] = frame }
    }

    // MARK: - Public API

    /// Show a coachmark if it hasn't been seen. No-op if another coachmark
    /// is currently visible or this one was already dismissed previously.
    func show(_ id: CoachmarkID) {
        guard visible == nil else {
            #if DEBUG
            print("[Coachmark] Skipped \(id.rawValue) — \(visible!.id.rawValue) already visible")
            #endif
            return
        }
        guard !hasSeen(id) else { return }
        let config = CoachmarkConfig.config(for: id)
        withAnimation(.easeOut(duration: 0.3)) {
            visible = config
        }
        shownAt = .now
        AnalyticsService.track(event: .coachmarkShown, properties: [
            "coachmark_id": id.rawValue
        ])
        HapticService.light()
    }

    /// Dismiss the visible coachmark and persist the seen flag so it never
    /// shows again.
    func dismiss() {
        guard let config = visible else { return }
        let elapsed = shownAt.map { Int(Date().timeIntervalSince($0)) } ?? 0
        markSeen(config.id)
        AnalyticsService.track(event: .coachmarkDismissed, properties: [
            "coachmark_id": config.id.rawValue,
            "dismissed_after_seconds": elapsed,
        ])
        withAnimation(.easeIn(duration: 0.2)) {
            visible = nil
        }
        shownAt = nil
    }

    // MARK: - Persistence

    private func key(for id: CoachmarkID) -> String { "coachmark_\(id.rawValue)_seen" }

    private func hasSeen(_ id: CoachmarkID) -> Bool {
        UserDefaults.standard.bool(forKey: key(for: id))
    }

    private func markSeen(_ id: CoachmarkID) {
        UserDefaults.standard.set(true, forKey: key(for: id))
    }

    // MARK: - Debug

    #if DEBUG
    /// QA helper: clear all coachmark seen flags so they fire again on next trigger.
    func resetAll() {
        for id in CoachmarkID.allCases {
            UserDefaults.standard.removeObject(forKey: key(for: id))
        }
        visible = nil
        shownAt = nil
        print("[Coachmark] Reset all seen flags")
    }
    #endif
}

