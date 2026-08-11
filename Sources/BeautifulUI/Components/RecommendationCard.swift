import SwiftUI

/// Reviewable agent suggestion. The library presents confidence; product policy remains in the host.
public struct RecommendationCard: View {
    public let recommendation: Recommendation
    public let onAccept: () -> Void
    public let onAlternatives: () -> Void

    public init(
        recommendation: Recommendation,
        onAccept: @escaping () -> Void,
        onAlternatives: @escaping () -> Void
    ) {
        self.recommendation = recommendation
        self.onAccept = onAccept
        self.onAlternatives = onAlternatives
    }

    public var body: some View {
        BeautifulSurface {
            VStack(alignment: .leading, spacing: BeautifulMetrics.regular) {
                Text(recommendation.title)
                    .font(.system(size: 13, weight: .semibold))
                Text(recommendation.summary)
                    .font(.system(size: 12.5))
                    .foregroundStyle(.secondary)
                if !recommendation.alternatives.isEmpty {
                    RecommendationAlternatives(alternatives: recommendation.alternatives)
                }
                HStack {
                    RecommendationConfidence(confidence: recommendation.confidence)
                    Spacer()
                    Button("Alternatives", action: onAlternatives)
                        .buttonStyle(BeautifulSecondaryButtonStyle())
                    Button("Accept", action: onAccept)
                        .buttonStyle(BeautifulPrimaryButtonStyle())
                }
            }
        }
    }
}

#Preview {
    RecommendationCard(
        recommendation: .init(
            title: "Ready to place this restock order?",
            summary: "Reorder waffle cones with a lead time of 7 days.",
            confidence: .high,
            alternatives: ["Switch to vanilla", "Review every SKU"]
        ),
        onAccept: {},
        onAlternatives: {}
    )
    .padding()
}
