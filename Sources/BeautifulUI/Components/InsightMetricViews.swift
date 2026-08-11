import SwiftUI

struct InsightMetricViews: View {
    let metrics: [Insight.Metric]

    var body: some View {
        ForEach(metrics) { metric in
            VStack(alignment: .leading, spacing: BeautifulMetrics.micro) {
                Text(metric.name)
                    .font(.system(size: 11.5))
                    .foregroundStyle(.secondary)
                Text(metric.delta, format: .percent.sign(strategy: .always()))
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(metric.delta >= 0 ? .green : .red)
                Text(metric.amount, format: .currency(code: "USD"))
                    .font(.system(size: 11.5))
                    .foregroundStyle(.secondary)
            }
        }
    }
}
