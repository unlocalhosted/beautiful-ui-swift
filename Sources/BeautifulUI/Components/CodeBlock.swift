import SwiftUI

/// Readable, selectable source display. Copying stays host-owned so clipboard policy is explicit.
public struct CodeBlock: View {
    public let snippet: CodeSnippet
    public let onCopy: () -> Void

    public init(snippet: CodeSnippet, onCopy: @escaping () -> Void = {}) {
        self.snippet = snippet
        self.onCopy = onCopy
    }

    public var body: some View {
        BeautifulSurface(padding: 0) {
            VStack(alignment: .leading, spacing: 0) {
                CodeBlockHeader(filename: snippet.filename, language: snippet.language, onCopy: onCopy)
                ScrollView(.horizontal) {
                    Text(snippet.source)
                        .font(.system(size: 11.5, design: .monospaced))
                        .textSelection(.enabled)
                        .padding(BeautifulMetrics.regular)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    CodeBlock(snippet: .init(filename: "churn.swift", language: "Swift", source: "func churnBatch() async throws {\n    let flavor = \"pistachio\"\n}"))
        .padding()
}
