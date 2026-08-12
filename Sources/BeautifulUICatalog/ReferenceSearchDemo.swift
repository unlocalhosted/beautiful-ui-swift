import BeautifulUI
import SwiftUI

/// Native port of the reference `Search` primitive.
struct ReferenceSearchDemo: View {
    @Environment(\.beautifulTheme) private var theme
    @State private var query = ""

    private static let commands = [
        "Forecast summer demand",
        "Find waffle cone suppliers",
        "Compare seasonal flavors",
        "Draft flavor launch plan",
        "Check cold-chain status",
        "Audit sugar costs",
        "Retire low sellers"
    ]

    private var matches: [String] {
        query.isEmpty ? Array(Self.commands.prefix(5)) : Self.commands.filter { $0.localizedStandardContains(query) }
    }

    private var showsEmptyState: Bool {
        query.count > 2 && matches.isEmpty
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.tertiary)
                TextField("Search flavors…", text: $query)
                    .textFieldStyle(.plain)
                    .font(.system(size: 13))
                    .foregroundStyle(.primary)
                if !query.isEmpty {
                    Button { query = "" } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 9, weight: .bold))
                            .frame(width: 22, height: 22)
                            .background(theme.border.opacity(0.8), in: .circle)
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.tertiary)
                    .accessibilityLabel("Clear search")
                }
            }
            .padding(.horizontal, 12)
            .frame(height: 40)
            .overlay(alignment: .bottom) { Rectangle().fill(theme.border).frame(height: 1) }

            Group {
                if showsEmptyState {
                    VStack(spacing: 4) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundStyle(.tertiary)
                            .frame(width: 32, height: 32)
                            .background(theme.elevatedSurface, in: .rect(cornerRadius: 7))
                            .padding(.bottom, 6)
                        Text("No results found")
                            .font(.system(size: 13, weight: .medium))
                        Text("Adjust your search to try again")
                            .font(.system(size: 12))
                            .foregroundStyle(.tertiary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.opacity)
                } else {
                    VStack(spacing: 0) {
                        ForEach(matches, id: \.self) { command in
                            Button(command) { query = command }
                                .font(.system(size: 13))
                                .foregroundStyle(.primary)
                                .frame(maxWidth: .infinity, minHeight: 32, alignment: .leading)
                                .padding(.horizontal, 8)
                                .contentShape(.rect)
                                .buttonStyle(ReferenceSearchRowStyle())
                                .transition(.opacity)
                        }
                    }
                    .padding(4)
                }
            }
        }
        .frame(width: 288, height: 248)
        .background(theme.surface, in: .rect(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(theme.border, lineWidth: 1))
        .shadow(color: .black.opacity(0.16), radius: 12, y: 4)
        .animation(.easeOut(duration: 0.2), value: query)
    }
}

private struct ReferenceSearchRowStyle: ButtonStyle {
    @Environment(\.beautifulTheme) private var theme
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.background(configuration.isPressed ? theme.elevatedSurface : .clear, in: .rect(cornerRadius: 6))
    }
}
