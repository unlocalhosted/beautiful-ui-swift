import BeautifulUI
import SwiftUI

struct CatalogIdentity: View {
    var body: some View {
        VStack(alignment: .leading, spacing: BeautifulMetrics.compact) {
            Image(systemName: "sparkles.square.filled.on.square")
                .font(.title)
                .foregroundStyle(.indigo)
                .accessibilityHidden(true)
            Text("AI-native primitives.")
                .font(.headline)
            Text("iOS and macOS · SwiftUI")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, BeautifulMetrics.compact)
    }
}
