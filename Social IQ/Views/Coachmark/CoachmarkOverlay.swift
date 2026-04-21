//
//  CoachmarkOverlay.swift
//  Social IQ
//
//  Renders the visible coachmark from `CoachmarkController.shared` at the
//  app root. Dims the screen, punches a spotlight around the target, and
//  shows a message bubble + diagonal arrow. Tap anywhere to dismiss.
//

import SwiftUI

struct CoachmarkOverlay: View {
    private let controller = CoachmarkController.shared
    @State private var bubbleAppeared = false
    @State private var arrowProgress: CGFloat = 0
    @Environment(\.scenePhase) private var scenePhase

    private enum Layout {
        static let spotlightPadding: CGFloat = 14
        static let bubbleMaxWidth: CGFloat = 280
        static let bubbleSidePadding: CGFloat = 24
        static let bubbleTopFraction: CGFloat = 0.3
        static let arrowLineWidth: CGFloat = 4
        static let arrowEndPadding: CGFloat = 8
        static let arrowStartInsetX: CGFloat = 30
        static let arrowStartInsetY: CGFloat = 4
        static let dimOpacity: Double = 0.78
    }

    private enum Timing {
        static let bubbleDuration: Double = 0.35
        static let arrowDuration: Double = 0.55
        static let arrowDelay: Double = 0.18
    }

    var body: some View {
        if let config = controller.visible, let globalSpotlight = controller.anchorFrames[config.id] {
            GeometryReader { geo in
                let overlayGlobal = geo.frame(in: .global)
                let spotlight = CGRect(
                    x: globalSpotlight.minX - overlayGlobal.minX,
                    y: globalSpotlight.minY - overlayGlobal.minY,
                    width: globalSpotlight.width,
                    height: globalSpotlight.height
                )
                let radius = max(spotlight.width, spotlight.height) / 2 + Layout.spotlightPadding
                let center = CGPoint(x: spotlight.midX, y: spotlight.midY)
                let bubbleBox = bubbleFrame(in: geo.size)

                ZStack(alignment: .topLeading) {
                    dimLayer(center: center, radius: radius)
                    arrow(from: bubbleBox, to: center, radius: radius)
                    bubble(config: config)
                        .frame(maxWidth: bubbleBox.width, alignment: .leading)
                        .position(x: bubbleBox.midX, y: bubbleBox.midY)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    HapticService.light()
                    controller.dismiss()
                }
                .onAppear { animateIn() }
                .onDisappear { resetAnimation() }
                .onChange(of: scenePhase) { _, newPhase in
                    if newPhase == .background { controller.dismiss() }
                }
            }
            .ignoresSafeArea()
            .transition(.opacity)
        }
    }

    // MARK: - Dim Layer

    private func dimLayer(center: CGPoint, radius: CGFloat) -> some View {
        Rectangle()
            .fill(Color.black.opacity(Layout.dimOpacity))
            .mask {
                Rectangle()
                    .overlay {
                        Circle()
                            .frame(width: radius * 2, height: radius * 2)
                            .position(x: center.x, y: center.y)
                            .blendMode(.destinationOut)
                    }
                    .compositingGroup()
            }
            .allowsHitTesting(false)
    }

    // MARK: - Bubble

    private func bubble(config: CoachmarkConfig) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(config.message)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)

            HStack {
                Spacer()
                Text(config.dismissLabel)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 8)
                    .background(Capsule().fill(Theme.goldGradient))
            }
        }
        .padding(18)
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
        .shadow(color: .black.opacity(Theme.Opacity.secondary), radius: 16, x: 0, y: 8)
        .scaleEffect(bubbleAppeared ? 1 : 0.85)
        .opacity(bubbleAppeared ? 1 : 0)
    }

    // MARK: - Arrow

    private func arrow(from bubble: CGRect, to spotlightCenter: CGPoint, radius: CGFloat) -> some View {
        let start = CGPoint(
            x: bubble.maxX - Layout.arrowStartInsetX,
            y: bubble.maxY + Layout.arrowStartInsetY
        )
        let dx = spotlightCenter.x - start.x
        let dy = spotlightCenter.y - start.y
        let length = max(sqrt(dx * dx + dy * dy), 1)
        let unitX = dx / length
        let unitY = dy / length
        let endOffset = radius + Layout.arrowEndPadding
        let end = CGPoint(
            x: spotlightCenter.x - unitX * endOffset,
            y: spotlightCenter.y - unitY * endOffset
        )

        return DiagonalArrowShape(from: start, to: end)
            .trim(from: 0, to: arrowProgress)
            .stroke(
                Theme.gold,
                style: StrokeStyle(
                    lineWidth: Layout.arrowLineWidth,
                    lineCap: .round,
                    lineJoin: .round
                )
            )
            .shadow(color: .black.opacity(Theme.Opacity.secondary), radius: 6, x: 0, y: 3)
            .allowsHitTesting(false)
    }

    // MARK: - Layout Helpers

    private func bubbleFrame(in size: CGSize) -> CGRect {
        let width = min(Layout.bubbleMaxWidth, size.width - Layout.bubbleSidePadding * 2)
        let x = (size.width - width) / 2
        let y = size.height * Layout.bubbleTopFraction
        return CGRect(x: x, y: y, width: width, height: 140)
    }

    // MARK: - Animation

    private func animateIn() {
        withAnimation(.spring(response: Timing.bubbleDuration, dampingFraction: 0.7)) {
            bubbleAppeared = true
        }
        withAnimation(.easeOut(duration: Timing.arrowDuration).delay(Timing.arrowDelay)) {
            arrowProgress = 1
        }
    }

    private func resetAnimation() {
        bubbleAppeared = false
        arrowProgress = 0
    }
}

// MARK: - Arrow Shape

private struct DiagonalArrowShape: Shape {
    let from: CGPoint
    let to: CGPoint

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: from)
        path.addLine(to: to)

        let angle = atan2(to.y - from.y, to.x - from.x)
        let arrowAngle: CGFloat = .pi / 7
        let arrowLength: CGFloat = 18
        let p1 = CGPoint(
            x: to.x - arrowLength * cos(angle - arrowAngle),
            y: to.y - arrowLength * sin(angle - arrowAngle)
        )
        let p2 = CGPoint(
            x: to.x - arrowLength * cos(angle + arrowAngle),
            y: to.y - arrowLength * sin(angle + arrowAngle)
        )
        path.move(to: p1)
        path.addLine(to: to)
        path.addLine(to: p2)
        return path
    }
}
