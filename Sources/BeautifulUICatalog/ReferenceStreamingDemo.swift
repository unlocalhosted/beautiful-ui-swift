import BeautifulUI
import SwiftUI

/// Native port of the reference `Streaming` primitive's word-by-word answer.
struct ReferenceStreamingDemo: View {
    @Environment(\.accessibilityReduceMotion) private var reducesMotion
    @Environment(\.beautifulTheme) private var theme
    @State private var visibleTokenCount = 0
    @State private var showsSources = false

    private let tokens: [ReferenceStreamingToken] =
        "Pistachio is your fastest-growing flavor — sales are up 23% this month and margins beat vanilla by 8 points."
            .split(separator: " ")
            .map { .word(String($0)) }
        + [.citation]
        + "Stone-fruit flavors are trending in the same range."
            .split(separator: " ")
            .map { .word(String($0)) }

    private let sources: [ReferenceStreamingSource] = [
        .init(name: "Scoop Data", domain: "scoopdata.io", destination: URL(string: "https://scoopdata.io/")!, tint: Color(red: 0.12, green: 0.48, blue: 0.37), symbol: "icecream"),
        .init(name: "Trends Index", domain: "trends.google.com", destination: URL(string: "https://trends.google.com/trends/")!, tint: Color(red: 0.18, green: 0.44, blue: 0.93), symbol: "chart.line.uptrend.xyaxis"),
        .init(name: "Market Basket", domain: "marketbasket.io", destination: URL(string: "https://marketbasket.io/")!, tint: Color(red: 0.90, green: 0.43, blue: 0.14), symbol: "chart.bar")
    ]

    private var hasFinished: Bool {
        visibleTokenCount >= tokens.count
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            streamedText

            HStack(spacing: 2) {
                ForEach(["doc.on.doc", "arrow.clockwise", "hand.thumbsup", "hand.thumbsdown"], id: \.self) { symbol in
                    Button(action: {}) {
                        Image(systemName: symbol)
                            .font(.system(size: 12, weight: .medium))
                            .frame(width: 24, height: 24)
                    }
                    .buttonStyle(ReferenceStreamingIconButtonStyle())
                    .accessibilityLabel(symbol)
                }

                Button {
                    showsSources.toggle()
                } label: {
                    HStack(spacing: 6) {
                        HStack(spacing: -4) {
                            ForEach(sources) { source in
                                ReferenceStreamingSourceIcon(source: source, size: 14)
                                    .overlay(Circle().stroke(theme.canvas, lineWidth: 1.5))
                            }
                        }
                        Text("10 sources")
                            .font(.system(size: 12))
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                }
                .buttonStyle(.plain)
                .opacity(hasFinished ? 1 : 0)
                .allowsHitTesting(hasFinished)
            }
            .padding(.top, 8)
            .opacity(hasFinished ? 1 : 0)
            .animation(.easeOut(duration: 0.4), value: hasFinished)

            if hasFinished && showsSources {
                VStack(spacing: 0) {
                    ForEach(sources) { source in
                        Link(destination: source.destination) {
                            HStack(spacing: 8) {
                                ReferenceStreamingSourceIcon(source: source, size: 16)
                                Text(source.name)
                                    .font(.system(size: 12))
                                    .foregroundStyle(.secondary)
                                Spacer(minLength: 0)
                                Text(source.domain)
                                    .font(.system(size: 10.5, design: .monospaced))
                                    .foregroundStyle(.tertiary)
                            }
                            .padding(.horizontal, 6)
                            .padding(.vertical, 4)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(4)
                .background(theme.elevatedSurface, in: .rect(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(theme.border, lineWidth: 1)
                }
                .padding(.top, 6)
                .transition(referenceFadeUp)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text("Follow-ups")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 2)

                ForEach(Array(Self.followUps.enumerated()), id: \.element) { index, question in
                    Button(action: {}) {
                        HStack(spacing: 8) {
                            Image(systemName: "arrow.turn.down.left")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundStyle(.tertiary)
                            Text(question)
                                .font(.system(size: 12.5))
                                .foregroundStyle(.primary)
                            Spacer(minLength: 0)
                        }
                        .padding(.horizontal, 6)
                        .padding(.vertical, 6)
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .fill(theme.border)
                                .frame(height: 1)
                        }
                    }
                    .buttonStyle(.plain)
                    .opacity(hasFinished ? 1 : 0)
                    .offset(y: hasFinished ? 0 : 6)
                    .animation(.timingCurve(0.23, 1, 0.32, 1, duration: 0.35).delay(Double(index) * 0.09), value: hasFinished)
                }
            }
            .padding(.top, 10)
            .opacity(hasFinished ? 1 : 0)
            .allowsHitTesting(hasFinished)
            .animation(.easeOut(duration: 0.4), value: hasFinished)
        }
        .frame(maxWidth: 380, minHeight: 248, alignment: .topLeading)
        .task {
            await streamTokens()
        }
    }

    private var streamedText: some View {
        Text(buildStreamedText())
            .font(.system(size: 13))
            .foregroundStyle(.primary)
            .lineSpacing(3)
            .overlay(alignment: .bottomLeading) {
                if !hasFinished {
                    Capsule()
                        .fill(Color.primary)
                        .frame(width: 2, height: 12)
                        .offset(x: cursorOffset, y: 7)
                        .transition(.opacity)
                }
            }
            .accessibilityLabel(buildStreamedText())
    }

    private func buildStreamedText() -> String {
        tokens.prefix(visibleTokenCount).map { token in
            switch token {
            case let .word(value): value
            case .citation: "[scoopdata.io]"
            }
        }
        .joined(separator: " ")
    }

    private var cursorOffset: CGFloat {
        // The native text system owns exact glyph layout; a small caret at the end
        // of the paragraph is intentionally preferable to faking a web text measure.
        0
    }

    private func streamTokens() async {
        await MainActor.run {
            visibleTokenCount = reducesMotion ? tokens.count : 0
            showsSources = false
        }
        guard !reducesMotion else { return }

        while !Task.isCancelled {
            let delay = hasFinished ? 3_400 : 55
            do {
                try await Task.sleep(for: .milliseconds(delay))
            } catch {
                return
            }
            await MainActor.run {
                withAnimation(.timingCurve(0.22, 0.61, 0.25, 1, duration: 0.42)) {
                    visibleTokenCount = hasFinished ? 0 : visibleTokenCount + 1
                    if visibleTokenCount == 0 { showsSources = false }
                }
            }
        }
    }

    private var referenceFadeUp: AnyTransition {
        .asymmetric(insertion: .opacity.combined(with: .offset(y: 6)), removal: .opacity)
    }

    private static let followUps = [
        "Which flavors sell best in winter",
        "Compare gelato and soft serve margins"
    ]
}

private enum ReferenceStreamingToken {
    case word(String)
    case citation
}

private struct ReferenceStreamingSource: Identifiable {
    let id = UUID()
    let name: String
    let domain: String
    let destination: URL
    let tint: Color
    let symbol: String
}

private struct ReferenceStreamingSourceIcon: View {
    let source: ReferenceStreamingSource
    let size: CGFloat

    var body: some View {
        RoundedRectangle(cornerRadius: size / 4)
            .fill(source.tint)
            .frame(width: size, height: size)
            .overlay {
                Image(systemName: source.symbol)
                    .font(.system(size: size * 0.45, weight: .bold))
                    .foregroundStyle(.white)
            }
    }
}

private struct ReferenceStreamingIconButtonStyle: ButtonStyle {
    @Environment(\.beautifulTheme) private var theme

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.tertiary)
            .background(configuration.isPressed ? theme.elevatedSurface : .clear, in: .rect(cornerRadius: 6))
    }
}
