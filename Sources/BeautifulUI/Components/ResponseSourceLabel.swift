import SwiftUI

struct ResponseSourceLabel: View {
    let source: ReferenceSource

    var body: some View {
        LabeledContent(source.title) {
            Text(source.subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
        .font(.subheadline)
    }
}
