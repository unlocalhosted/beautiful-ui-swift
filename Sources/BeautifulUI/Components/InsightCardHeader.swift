import SwiftUI

struct InsightCardHeader: View {
    let insights: [Insight]
    @Binding var selectedInsightID: Insight.ID?

    var body: some View {
        HStack {
            Text("Insights")
                .font(.system(size: 13, weight: .semibold))
            Text("\(insights.count)")
                .font(.system(size: 11.5))
                .foregroundStyle(.secondary)
            Spacer()
            Button("Previous insight", systemImage: "chevron.left", action: selectPrevious)
                .labelStyle(.iconOnly)
                .buttonStyle(BeautifulIconButtonStyle())
                .disabled(insights.count < 2)
            Button("Next insight", systemImage: "chevron.right", action: selectNext)
                .labelStyle(.iconOnly)
                .buttonStyle(BeautifulIconButtonStyle())
                .disabled(insights.count < 2)
        }
    }

    private func selectPrevious() {
        selectedInsightID = adjacentInsight(offset: -1)?.id
    }

    private func selectNext() {
        selectedInsightID = adjacentInsight(offset: 1)?.id
    }

    private func adjacentInsight(offset: Int) -> Insight? {
        guard !insights.isEmpty else { return nil }
        let currentIndex = insights.firstIndex(where: { $0.id == selectedInsightID }) ?? 0
        let nextIndex = (currentIndex + offset + insights.count) % insights.count
        return insights[nextIndex]
    }
}
