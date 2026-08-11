import SwiftUI

/// Compact disclosure for an agent's tool activity.
public struct ToolCallGroup: View {
    public let calls: [ToolCall]

    @State private var isExpanded: Bool

    public init(calls: [ToolCall], initiallyExpanded: Bool = false) {
        self.calls = calls
        _isExpanded = State(initialValue: initiallyExpanded)
    }

    public var body: some View {
        BeautifulSurface {
            DisclosureGroup(isExpanded: $isExpanded) {
                VStack(alignment: .leading, spacing: BeautifulMetrics.compact) {
                    ForEach(calls) { call in
                        ToolCallRow(call: call)
                    }
                }
                .padding(.top, BeautifulMetrics.regular)
            } label: {
                Label("\(calls.count) tool calls", systemImage: "hammer")
                    .font(.system(size: 13, weight: .medium))
            }
        }
    }
}

#Preview {
    ToolCallGroup(calls: [.init(kind: .read, title: "Read inventory.csv", detail: "1,024 rows")], initiallyExpanded: true)
        .padding()
}
