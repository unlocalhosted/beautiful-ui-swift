import SwiftUI

/// Accessible loading feedback with elapsed time and a configurable visual treatment.
public struct LoadingStateView: View {
    public let label: String
    public let startedAt: Date
    public let style: LoadingStyle

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(label: String, startedAt: Date = .now, style: LoadingStyle = .grid) {
        self.label = label
        self.startedAt = startedAt
        self.style = style
    }

    public var body: some View {
        HStack(spacing: BeautifulMetrics.compact) {
            LoadingIndicator(style: style, reduceMotion: reduceMotion)
            Text(label)
                .font(.system(size: 13, weight: .medium))
            Text(startedAt, style: .timer)
                .font(.system(size: 12, design: .monospaced))
                .foregroundStyle(.secondary)
                .monospacedDigit()
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(label). Elapsed time")
    }

}

#Preview {
    LoadingStateView(label: "Churning", startedAt: .now.addingTimeInterval(-12), style: .orbit)
        .padding()
}
