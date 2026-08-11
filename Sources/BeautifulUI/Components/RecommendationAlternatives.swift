import SwiftUI

struct RecommendationAlternatives: View {
    let alternatives: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: BeautifulMetrics.compact) {
            Text("Other options")
                .font(.system(size: 11.5))
                .foregroundStyle(.secondary)
            ForEach(alternatives, id: \.self) { alternative in
                Label(alternative, systemImage: "arrow.triangle.branch")
                    .font(.system(size: 12.5))
                    .foregroundStyle(.secondary)
            }
        }
    }
}
