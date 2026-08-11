import SwiftUI

struct RecommendationConfidence: View {
    let confidence: Recommendation.Confidence

    @Environment(\.beautifulTheme) private var theme

    var body: some View {
        Label(confidence.title, systemImage: "chart.bar.fill")
            .font(.system(size: 11.5, weight: .medium))
            .foregroundStyle(confidence == .high ? theme.positive : confidence == .moderate ? theme.warning : .secondary)
            .accessibilityLabel("Recommendation confidence: \(confidence.title)")
    }
}
