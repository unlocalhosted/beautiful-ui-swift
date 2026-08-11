import SwiftUI

struct ResponseSourceRow: View {
    let source: ReferenceSource

    var body: some View {
        Group {
            if let url = source.url {
                Link(destination: url) {
                    ResponseSourceLabel(source: source)
                }
            } else {
                ResponseSourceLabel(source: source)
            }
        }
        .padding(BeautifulMetrics.compact)
        .background(.quaternary.opacity(0.32), in: .rect(cornerRadius: 6))
    }

}
