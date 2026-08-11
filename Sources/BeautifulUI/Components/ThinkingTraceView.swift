import SwiftUI

/// Disclosure-based trace that lets people inspect agent work without forcing them to read it.
public struct ThinkingTraceView: View {
    public let title: String
    public let steps: [ThinkingStep]

    @State private var isExpanded: Bool

    public init(title: String = "Thinking", steps: [ThinkingStep], initiallyExpanded: Bool = false) {
        self.title = title
        self.steps = steps
        _isExpanded = State(initialValue: initiallyExpanded)
    }

    public var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            VStack(alignment: .leading, spacing: 6) {
                ForEach(steps) { step in
                    ThinkingStepRow(step: step)
                }
            }
            .padding(.top, 8)
            .padding(.leading, 4)
        } label: {
            Label(title, systemImage: "sparkles")
                .font(.system(size: 13, weight: .medium))
        }
    }
}

#Preview {
    ThinkingTraceView(
        steps: [
            .init(kind: .planning, title: "Plan response", detail: "Checking inventory forecast."),
            .init(kind: .search, title: "Find matching records", detail: "Found 12 supplier entries.")
        ],
        initiallyExpanded: true
    )
    .padding()
}
