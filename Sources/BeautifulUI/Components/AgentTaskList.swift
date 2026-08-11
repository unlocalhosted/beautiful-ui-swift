import SwiftUI

/// Adaptive collection of live agent tasks.
public struct AgentTaskList: View {
    public let tasks: [AgentTask]

    public init(tasks: [AgentTask]) {
        self.tasks = tasks
    }

    public var body: some View {
        BeautifulSurface {
            VStack(alignment: .leading, spacing: BeautifulMetrics.regular) {
                Text("Agent tasks")
                    .font(.system(size: 13, weight: .semibold))
                if tasks.isEmpty {
                    Text("No agent tasks")
                        .font(.system(size: 12.5))
                        .foregroundStyle(.secondary)
                        .padding(.vertical, BeautifulMetrics.section)
                } else {
                    ForEach(tasks) { task in
                        AgentTaskRow(task: task)
                    }
                }
            }
        }
    }
}

#Preview {
    AgentTaskList(tasks: [
        .init(title: "Verify vendor records", detail: "Matched tax and contact IDs", state: .completed, quantityLabel: "12 suppliers"),
        .init(title: "Build reorder task list", detail: "Scoring stockout risk", state: .running, progress: 0.68, quantityLabel: "7 SKUs")
    ])
    .padding()
}
