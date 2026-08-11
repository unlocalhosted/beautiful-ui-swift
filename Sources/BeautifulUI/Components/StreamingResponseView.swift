import SwiftUI

/// Answer content with optional source links, compact actions, and suggested follow-ups.
public struct StreamingResponseView: View {
    public let text: String
    public let sources: [ReferenceSource]
    public let actions: [ResponseAction]
    public let followUps: [String]
    public let onAction: (ResponseAction) -> Void
    public let onFollowUp: (String) -> Void

    public init(
        text: String,
        sources: [ReferenceSource] = [],
        actions: [ResponseAction] = [],
        followUps: [String] = [],
        onAction: @escaping (ResponseAction) -> Void = { _ in },
        onFollowUp: @escaping (String) -> Void = { _ in }
    ) {
        self.text = text
        self.sources = sources
        self.actions = actions
        self.followUps = followUps
        self.onAction = onAction
        self.onFollowUp = onFollowUp
    }

    public var body: some View {
        BeautifulSurface {
            VStack(alignment: .leading, spacing: BeautifulMetrics.roomy) {
                Text(text)
                    .font(.system(size: 13))
                    .lineSpacing(2)
                    .textSelection(.enabled)
                if !actions.isEmpty {
                    ResponseActionRow(actions: actions, onAction: onAction)
                }
                if !sources.isEmpty {
                    ResponseSourceList(sources: sources)
                }
                if !followUps.isEmpty {
                    FollowUpList(followUps: followUps, onFollowUp: onFollowUp)
                }
            }
        }
    }
}

#Preview {
    StreamingResponseView(
        text: "Pistachio is your fastest-growing flavor. Sales are up 23% this month.",
        sources: [.init(title: "Sales dashboard", subtitle: "dashboard.example.com")],
        actions: [.init(title: "Save", symbolName: "bookmark")],
        followUps: ["Compare gelato and soft serve margins"]
    )
    .padding()
}
