import BeautifulUI
import SwiftUI

/// Native port of the reference `Recommendation` primitive.
struct ReferenceRecommendationDemo: View {
    @Environment(\.beautifulTheme) private var theme
    @State private var selectedOption = 0
    @State private var showsAlternatives = false
    @State private var isAccepted = false

    private static let options = [
        ReferenceRecommendationOption(
            short: "Reorder from cone_king · 7-day lead",
            pieces: [.plain("Reorder waffle cones from"), .token("cone_king", tint: .blue), .plain("with lead time"), .token("7_days", tint: .blue)],
            signal: 3, tint: .green, label: "High confidence", cta: "Accept"
        ),
        ReferenceRecommendationOption(
            short: "Switch to vanilla_madagascar",
            pieces: [.plain("Switch vanilla to"), .token("vanilla_madagascar", tint: .orange), .plain("for peak season.")],
            signal: 2, tint: .orange, label: "Needs review", cta: "Configure"
        ),
        ReferenceRecommendationOption(
            short: "Full restock across every SKU",
            pieces: [.plain("Fall back to a "), .strong("full restock"), .plain(" across every SKU.")],
            signal: 0, tint: .secondary, label: "No signal", cta: "Accept full restock"
        )
    ]

    private var option: ReferenceRecommendationOption { Self.options[selectedOption] }

    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Want me to place this restock order?")
                    .font(.system(size: 13, weight: .semibold))

                recommendationText(option)
                    .id(selectedOption)
                    .transition(.opacity)
                    .frame(minHeight: 48, alignment: .topLeading)
            }
            .padding(14)

            if showsAlternatives {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Other options")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(.tertiary)
                        .padding(.horizontal, 6)
                        .padding(.bottom, 4)

                    ForEach(Array(Self.options.enumerated()).filter { $0.offset != selectedOption }, id: \.element.id) { index, alternative in
                        Button {
                            selectedOption = index
                            showsAlternatives = false
                            isAccepted = false
                        } label: {
                            HStack(spacing: 10) {
                                ReferenceSignalBars(signal: alternative.signal, tint: alternative.tint)
                                Text(alternative.short)
                                    .font(.system(size: 12.5))
                                    .foregroundStyle(.primary)
                                    .lineLimit(1)
                                Spacer(minLength: 0)
                                Text(alternative.label)
                                    .font(.system(size: 11))
                                    .foregroundStyle(.tertiary)
                            }
                            .padding(.horizontal, 6)
                            .padding(.vertical, 6)
                            .contentShape(.rect)
                        }
                        .buttonStyle(ReferenceRecommendationRowStyle())
                    }
                }
                .padding(8)
                .background(theme.elevatedSurface)
                .overlay(alignment: .top) { Rectangle().fill(theme.border).frame(height: 1) }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }

            HStack(spacing: 12) {
                HStack(spacing: 8) {
                    ReferenceSignalBars(signal: option.signal, tint: option.tint)
                    Text(option.label)
                        .font(.system(size: 12.5, weight: .medium))
                        .foregroundStyle(.secondary)
                }
                Spacer(minLength: 0)
                HStack(spacing: 8) {
                    Button("Alternatives") { showsAlternatives.toggle() }
                        .font(.system(size: 12.5, weight: .medium))
                        .padding(.horizontal, 10)
                        .frame(height: 28)
                        .background(showsAlternatives ? theme.elevatedSurface : theme.surface, in: .rect(cornerRadius: 7))
                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(theme.border, lineWidth: 1))
                        .buttonStyle(.plain)
                    Button(isAccepted ? "Accepted" : option.cta) { isAccepted = true }
                        .font(.system(size: 12.5, weight: .medium))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .frame(height: 28)
                        .background(isAccepted ? theme.positive : (selectedOption == 0 ? theme.accent : Color.primary), in: .rect(cornerRadius: 7))
                        .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(theme.elevatedSurface)
            .overlay(alignment: .top) { Rectangle().fill(theme.border).frame(height: 1) }
        }
        .frame(maxWidth: 380, alignment: .leading)
        .background(theme.surface, in: .rect(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(theme.border, lineWidth: 1))
        .shadow(color: .black.opacity(0.15), radius: 9, y: 3)
        .animation(.timingCurve(0.16, 1, 0.3, 1, duration: 0.3), value: showsAlternatives)
        .animation(.easeOut(duration: 0.18), value: selectedOption)
    }

    private func recommendationText(_ option: ReferenceRecommendationOption) -> some View {
        HStack(spacing: 4) {
            ForEach(Array(option.pieces.enumerated()), id: \.offset) { _, piece in
                switch piece {
                case let .plain(value):
                    Text(value)
                case let .strong(value):
                    Text(value).fontWeight(.medium).foregroundStyle(.primary)
                case let .token(value, tint):
                    Text(value)
                        .font(.system(size: 12, design: .monospaced))
                        .foregroundStyle(tint == .blue ? theme.accent : theme.warning)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background((tint == .blue ? theme.accent : theme.warning).opacity(0.14), in: .rect(cornerRadius: 4))
                }
            }
        }
        .font(.system(size: 13))
        .foregroundStyle(.secondary)
    }
}

private struct ReferenceRecommendationOption: Identifiable {
    let short: String
    let pieces: [ReferenceRecommendationPiece]
    let signal: Int
    let tint: Color
    let label: String
    let cta: String
    var id: String { short }
}

private enum ReferenceRecommendationPiece {
    case plain(String)
    case strong(String)
    case token(String, tint: TokenTint)
    enum TokenTint { case blue, orange }
}

private struct ReferenceSignalBars: View {
    let signal: Int
    let tint: Color
    var body: some View {
        HStack(alignment: .bottom, spacing: 2) {
            ForEach(0 ..< 3, id: \.self) { index in
                Capsule()
                    .fill(index < signal ? tint : Color.secondary.opacity(0.35))
                    .frame(width: 4, height: 10)
            }
        }
    }
}

private struct ReferenceRecommendationRowStyle: ButtonStyle {
    @Environment(\.beautifulTheme) private var theme
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.background(configuration.isPressed ? theme.surface : .clear, in: .rect(cornerRadius: 7))
    }
}
