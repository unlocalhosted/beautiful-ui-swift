import BeautifulUI
import SwiftUI

struct CatalogHeader: View {
    let section: CatalogSection

    var body: some View {
        VStack(alignment: .leading, spacing: BeautifulMetrics.compact) {
            Text(section.number, format: .number.precision(.integerLength(2)))
                .font(.caption)
                .foregroundStyle(.secondary)
                .monospacedDigit()
            Text(section.title)
                .font(.largeTitle)
                .bold()
            Text(section.subtitle)
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .combine)
    }
}
