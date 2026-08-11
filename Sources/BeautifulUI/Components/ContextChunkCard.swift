import SwiftUI

/// A source-backed unit of context surfaced to an AI workflow.
public struct ContextChunkCard: View {
    public let chunk: ContextChunk

    public init(chunk: ContextChunk) {
        self.chunk = chunk
    }

    public var body: some View {
        BeautifulSurface(padding: BeautifulMetrics.regular) {
            VStack(alignment: .leading, spacing: BeautifulMetrics.compact) {
                HStack {
                    Label(chunk.title, systemImage: chunk.sourceKind.symbolName)
                        .font(.system(size: 12.5, weight: .medium))
                    Spacer()
                    Text("\(chunk.characterCount) characters")
                        .font(.system(size: 11.5))
                        .foregroundStyle(.secondary)
                }
                Text(chunk.excerpt)
                    .font(.system(size: 12.5))
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
                Label(chunk.sourceName, systemImage: chunk.sourceKind.symbolName)
                    .font(.system(size: 11.5))
                    .foregroundStyle(.secondary)
            }
        }
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    ContextChunkCard(chunk: .init(title: "Vendor onboarding rule", excerpt: "Cold-chain certification must be verified before a new dairy can be added.", sourceName: "Dairy Onboarding SOP.pdf", sourceKind: .document, characterCount: 290))
        .padding()
}
