import SwiftUI

struct InsightMetricList: View {
    let metrics: [Insight.Metric]

    var body: some View {
        ViewThatFits(in: .horizontal) {
            HStack(spacing: BeautifulMetrics.section) {
                InsightMetricViews(metrics: metrics)
            }
            VStack(alignment: .leading, spacing: BeautifulMetrics.compact) {
                InsightMetricViews(metrics: metrics)
            }
        }
    }
}
