import SwiftUI

/// Search field with host-owned query state and explicit suggestion selection.
public struct CommandSearch: View {
    @Binding public var query: String
    public let suggestions: [String]
    public let onSelect: (String) -> Void

    public init(query: Binding<String>, suggestions: [String], onSelect: @escaping (String) -> Void) {
        _query = query
        self.suggestions = suggestions
        self.onSelect = onSelect
    }

    public var body: some View {
        BeautifulSurface(padding: BeautifulMetrics.compact) {
            VStack(alignment: .leading, spacing: BeautifulMetrics.compact) {
                HStack(spacing: 7) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.secondary)
                    TextField("Search", text: $query)
                        .textFieldStyle(.plain)
                        .font(.system(size: 12.5))
                        .accessibilityInputLabels(["Search commands"])
                }
                .padding(.horizontal, 10)
                .frame(height: BeautifulMetrics.controlHeight)
                .background(.quaternary.opacity(0.32), in: .rect(cornerRadius: 8))
                if filteredSuggestions.isEmpty {
                    Text("No matching commands")
                        .font(.system(size: 12.5))
                        .foregroundStyle(.secondary)
                        .padding(.vertical, BeautifulMetrics.section)
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    ForEach(filteredSuggestions, id: \.self) { suggestion in
                        Button(suggestion, action: { onSelect(suggestion) })
                            .buttonStyle(.plain)
                            .font(.system(size: 12.5))
                            .frame(maxWidth: .infinity, minHeight: BeautifulMetrics.controlHeight, alignment: .leading)
                    }
                }
            }
        }
    }

    private var filteredSuggestions: [String] {
        guard !query.isEmpty else { return suggestions }
        return suggestions.filter { $0.localizedStandardContains(query) }
    }
}

#Preview {
    CommandSearch(query: .constant(""), suggestions: ["Forecast summer demand", "Find waffle cone suppliers"], onSelect: { _ in })
        .padding()
}
