import SwiftUI

/// State label with both color and icon differentiation.
public struct StatusBadge: View {
    public let state: AgentTaskState

    @Environment(\.beautifulTheme) private var theme
    @Environment(\.accessibilityDifferentiateWithoutColor) private var differentiateWithoutColor

    public init(state: AgentTaskState) {
        self.state = state
    }

    public var body: some View {
        Label(state.title, systemImage: state.symbolName)
            .font(.system(size: 11, weight: .medium))
            .foregroundStyle(foregroundStyle)
            .padding(.horizontal, BeautifulMetrics.compact)
            .padding(.vertical, BeautifulMetrics.micro)
            .background(backgroundStyle, in: .capsule)
            .overlay {
                if differentiateWithoutColor {
                    Capsule().stroke(foregroundStyle.opacity(0.7), lineWidth: 1)
                }
            }
            .accessibilityLabel("Task state: \(state.title)")
    }

    private var foregroundStyle: Color {
        switch state {
        case .queued, .running: theme.accent
        case .needsReview: theme.warning
        case .completed: theme.positive
        case .failed: theme.negative
        }
    }

    private var backgroundStyle: Color {
        foregroundStyle.opacity(0.14)
    }
}

#Preview {
    StatusBadge(state: .needsReview)
        .padding()
}
