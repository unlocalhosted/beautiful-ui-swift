import SwiftUI

struct ResponseSourceList: View {
    let sources: [ReferenceSource]

    var body: some View {
        VStack(alignment: .leading, spacing: BeautifulMetrics.compact) {
            Text("Sources")
                .font(.caption)
                .foregroundStyle(.secondary)
            ForEach(sources) { source in
                ResponseSourceRow(source: source)
            }
        }
    }
}
