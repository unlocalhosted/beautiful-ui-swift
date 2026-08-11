import SwiftUI

/// Moving neutral gradient used by streamed and in-progress reference labels.
public struct BeautifulShimmerText: View {
    let text: String
    let font: Font
    let duration: TimeInterval

    @Environment(\.accessibilityReduceMotion) private var reducesMotion

    public init(_ text: String, font: Font = .system(size: 13, weight: .medium), duration: TimeInterval = 1.4) {
        self.text = text
        self.font = font
        self.duration = duration
    }

    public var body: some View {
        TimelineView(.animation(minimumInterval: reducesMotion ? 1 : 1 / 30)) { timeline in
            let progress = reducesMotion ? 0.5 : timeline.date.timeIntervalSinceReferenceDate.truncatingRemainder(dividingBy: duration) / duration
            Text(text)
                .font(font)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.secondary, .secondary, .primary, .secondary, .secondary],
                        startPoint: .init(x: -1 + 2 * progress, y: 0.5),
                        endPoint: .init(x: 1 + 2 * progress, y: 0.5)
                    )
                )
        }
    }
}
