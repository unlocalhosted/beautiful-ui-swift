import BeautifulUI
import SwiftUI

/// Native port of the reference `Code` primitive's line-by-line replay.
struct ReferenceCodeDemo: View {
    @Environment(\.accessibilityReduceMotion) private var reducesMotion
    @Environment(\.beautifulTheme) private var theme
    @State private var visibleLines = 0
    @State private var didCopy = false

    private let lines: [[ReferenceCodeToken]] = [
        [.init("export async function ", .keyword), .init("churnBatch", .function), .init("() {", .dim)],
        [.init("  const ", .keyword), .init("flavor = ", .default), .init("await ", .keyword), .init("getFlavor", .function), .init("(", .dim), .init("\"pistachio\"", .string), .init(");", .dim)],
        [.init("  const ", .keyword), .init("base = ", .default), .init("await ", .keyword), .init("dairy.", .default), .init("fetch", .function), .init("({ flavor });", .dim)],
        [.init("  await ", .keyword), .init("freezer.", .default), .init("store", .function), .init("(base, { temp: ", .dim), .init("\"-14C\"", .string), .init(" });", .dim)],
        [.init("  return ", .keyword), .init("base.gallons;", .default)],
        [.init("}", .dim)]
    ]

    private var hasFinished: Bool { visibleLines >= lines.count }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text("churn.ts")
                        .font(.system(size: 12, weight: .medium, design: .monospaced))
                    Text("TypeScript")
                        .font(.system(size: 11.5))
                        .foregroundStyle(.tertiary)
                }
                Spacer()
                Button {
                    didCopy = true
                    Task { @MainActor in
                        try? await Task.sleep(for: .milliseconds(1_500))
                        didCopy = false
                    }
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: didCopy ? "checkmark" : "doc.on.doc")
                            .font(.system(size: 10, weight: .bold))
                        Text(didCopy ? "Copied" : "Copy")
                    }
                    .font(.system(size: 11.5, weight: .medium))
                    .foregroundStyle(didCopy ? theme.positive : Color.secondary)
                    .padding(.horizontal, 6)
                    .frame(height: 24)
                }
                .buttonStyle(ReferenceCodeCopyStyle())
                .accessibilityLabel("Copy code")
            }
            .padding(.horizontal, 12)
            .frame(height: 36)
            .overlay(alignment: .bottom) { Rectangle().fill(theme.border).frame(height: 1) }

            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(lines.prefix(visibleLines).enumerated()), id: \.offset) { lineIndex, line in
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Text("\(lineIndex + 1)")
                            .font(.system(size: 10.5, design: .monospaced))
                            .foregroundStyle(.tertiary.opacity(0.6))
                            .frame(width: 20, alignment: .trailing)
                        HStack(spacing: 0) {
                            ForEach(line) { token in
                                Text(token.text)
                                    .foregroundStyle(token.color(theme: theme))
                            }
                            if lineIndex == visibleLines - 1 && !hasFinished {
                                Capsule().fill(theme.accent).frame(width: 3, height: 12)
                                    .padding(.leading, 2)
                            }
                        }
                        .padding(.leading, 10)
                    }
                    .font(.system(size: 11.5, design: .monospaced))
                    .frame(height: 20, alignment: .leading)
                    .transition(.opacity.combined(with: .offset(y: 5)))
                }
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .frame(minHeight: 137, alignment: .topLeading)
            .background(theme.elevatedSurface)
        }
        .frame(maxWidth: 380, alignment: .leading)
        .background(theme.surface, in: .rect(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(theme.border, lineWidth: 1))
        .shadow(color: .black.opacity(0.15), radius: 9, y: 3)
        .animation(.timingCurve(0.23, 1, 0.32, 1, duration: 0.25), value: visibleLines)
        .task { await typeCode() }
    }

    private func typeCode() async {
        await MainActor.run { visibleLines = reducesMotion ? lines.count : 0 }
        guard !reducesMotion else { return }
        while !Task.isCancelled {
            let delay = visibleLines == 0 ? 400 : hasFinished ? 3_200 : 240
            do { try await Task.sleep(for: .milliseconds(delay)) }
            catch { return }
            await MainActor.run {
                withAnimation(.timingCurve(0.23, 1, 0.32, 1, duration: 0.25)) {
                    visibleLines = hasFinished ? 0 : visibleLines + 1
                }
            }
        }
    }
}

private struct ReferenceCodeToken: Identifiable {
    enum Kind { case keyword, function, string, dim, `default` }
    let id = UUID()
    let text: String
    let kind: Kind
    init(_ text: String, _ kind: Kind) { self.text = text; self.kind = kind }
    func color(theme: BeautifulTheme) -> Color {
        switch kind {
        case .keyword: theme.accent
        case .function: .primary
        case .string: theme.positive
        case .dim: .secondary
        case .default: .secondary
        }
    }
}

private struct ReferenceCodeCopyStyle: ButtonStyle {
    @Environment(\.beautifulTheme) private var theme
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.background(configuration.isPressed ? theme.elevatedSurface : .clear, in: .rect(cornerRadius: 6))
    }
}
