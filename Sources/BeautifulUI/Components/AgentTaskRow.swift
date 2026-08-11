import SwiftUI

/// One agent task with state, progress, and contextual quantity.
public struct AgentTaskRow: View {
    public let task: AgentTask

    public init(task: AgentTask) {
        self.task = task
    }

    public var body: some View {
        HStack(alignment: .top, spacing: BeautifulMetrics.regular) {
            Image(systemName: task.state.symbolName)
                .foregroundStyle(statusColor)
                .font(.system(size: 14, weight: .medium))
                .frame(width: 18)
            VStack(alignment: .leading, spacing: BeautifulMetrics.micro) {
                Text(task.title)
                    .font(.system(size: 12.5, weight: .medium))
                Text(task.detail)
                    .font(.system(size: 11.5))
                    .foregroundStyle(.secondary)
                if let progress = task.progress {
                    ProgressView(value: progress)
                        .tint(statusColor)
                        .accessibilityLabel("Progress")
                        .accessibilityValue(Text(progress, format: .percent))
                }
            }
            Spacer(minLength: BeautifulMetrics.compact)
            VStack(alignment: .trailing, spacing: BeautifulMetrics.compact) {
                if let quantityLabel = task.quantityLabel {
                    Text(quantityLabel)
                        .font(.system(size: 11.5))
                        .foregroundStyle(.secondary)
                }
                StatusBadge(state: task.state)
            }
        }
        .padding(BeautifulMetrics.regular)
        .background(.quaternary.opacity(0.32), in: .rect(cornerRadius: 8))
        .accessibilityElement(children: .combine)
    }

    @Environment(\.beautifulTheme) private var theme

    private var statusColor: Color {
        switch task.state {
        case .queued, .running: theme.accent
        case .needsReview: theme.warning
        case .completed: theme.positive
        case .failed: theme.negative
        }
    }
}

#Preview {
    AgentTaskRow(task: .init(title: "Verify vendor records", detail: "Matched tax and contact IDs", state: .completed, quantityLabel: "12 suppliers"))
        .padding()
}
