import Charts
import SwiftUI

/// Paged insight presentation with native Charts and explicit next/previous controls.
public struct InsightCard: View {
    public let insights: [Insight]
    @Binding public var selectedInsightID: Insight.ID?
    public let onAskFollowUp: (Insight) -> Void

    public init(
        insights: [Insight],
        selectedInsightID: Binding<Insight.ID?>,
        onAskFollowUp: @escaping (Insight) -> Void
    ) {
        self.insights = insights
        _selectedInsightID = selectedInsightID
        self.onAskFollowUp = onAskFollowUp
    }

    public var body: some View {
        BeautifulSurface {
            if let insight = selectedInsight {
                VStack(alignment: .leading, spacing: BeautifulMetrics.regular) {
                    InsightCardHeader(insights: insights, selectedInsightID: $selectedInsightID)
                    Text(insight.headline)
                        .font(.system(size: 13, weight: .semibold))
                    Text(insight.detail)
                        .font(.system(size: 12.5))
                        .foregroundStyle(.secondary)
                    InsightMetricList(metrics: insight.metrics)
                    InsightChart(series: insight.series)
                    Button("Ask follow-up", systemImage: "arrowshape.turn.up.left", action: { onAskFollowUp(insight) })
                        .buttonStyle(BeautifulSecondaryButtonStyle())
                }
            } else {
                Text("No insights")
                    .font(.system(size: 12.5))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding(BeautifulMetrics.section)
            }
        }
    }

    private var selectedInsight: Insight? {
        insights.first(where: { $0.id == selectedInsightID }) ?? insights.first
    }
}

#Preview {
    InsightCard(
        insights: [.init(headline: "Mint chip is climbing.", detail: "Weekend demand remains strong.", metrics: [.init(name: "Mint chip", delta: 0.12, amount: 617)], series: [[4, 6, 5, 8, 10]])],
        selectedInsightID: .constant(nil),
        onAskFollowUp: { _ in }
    )
    .padding()
}
