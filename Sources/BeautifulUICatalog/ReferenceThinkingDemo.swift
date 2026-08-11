import BeautifulUI
import SwiftUI

/// Native port of Beautiful UI's shipped `Thinking` primitive.
///
/// The phase cadence, automatic expansion, row staging, and interaction map
/// directly to the reference implementation rather than inventing a new trace.
struct ReferenceThinkingDemo: View {
    let variant: ReferenceThinkingVariant

    @Environment(\.accessibilityReduceMotion) private var reducesMotion
    @Environment(\.beautifulTheme) private var theme
    @State private var phase = 0
    @State private var expandedOverride: Bool?
    @State private var selectedCodingRow: String?

    private let phaseDelays = [800, 600, 1_800, 2_600, 1_600]

    private var content: ReferenceThinkingContent {
        ReferenceThinkingContent.forVariant(variant)
    }

    private var defaultExpansion: Bool {
        phase >= 1 && phase < 4
    }

    private var isExpanded: Bool {
        expandedOverride ?? defaultExpansion
    }

    private var isActive: Bool {
        phase < 3
    }

    private var visibleRowCount: Int {
        switch phase {
        case ..<2: 0
        case 2: min(2, content.rows.count)
        default: content.rows.count
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                expandedOverride = !isExpanded
            } label: {
                HStack(spacing: 8) {
                    ReferenceThinkingSparkle()
                        .fill(isActive ? Color.secondary : Color.secondary.opacity(0.65))
                        .frame(width: 16, height: 16)

                    if isActive {
                        BeautifulShimmerText(content.active, font: .system(size: 13, weight: .medium))
                    } else {
                        Text(content.done)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(.secondary)
                            .transition(.opacity)
                    }

                    Image(systemName: "chevron.down")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(.tertiary)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .contentShape(.rect)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(isActive ? content.active : content.done)
            .accessibilityValue(isExpanded ? "Expanded" : "Collapsed")

            if isExpanded {
                VStack(alignment: .leading, spacing: 4) {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(theme.border)
                            .frame(width: 1)
                            .padding(.leading, 3)
                            .padding(.vertical, -8)

                        VStack(alignment: .leading, spacing: 4) {
                            if let query = content.query {
                                HStack(spacing: 8) {
                                    Image(systemName: "magnifyingglass")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundStyle(.tertiary)
                                        .frame(width: 14)
                                    Text(query)
                                        .font(.system(size: 12.5))
                                        .foregroundStyle(.secondary)
                                }
                                .frame(height: 24)
                                .padding(.horizontal, 6)
                                .transition(referenceFadeUp)
                            }

                            ForEach(Array(content.rows.prefix(visibleRowCount).enumerated()), id: \.element.id) { index, row in
                                thinkingRow(row, index: index)
                                    .transition(referenceFadeUp)
                            }

                            if variant == .search && phase >= 3 {
                                Text("+7 more")
                                    .font(.system(size: 12))
                                    .foregroundStyle(.tertiary)
                                    .padding(.leading, 6)
                                    .transition(.opacity)
                            }
                        }
                        .padding(.vertical, 4)
                        .padding(.leading, 16)
                    }
                }
                .padding(.top, 4)
                .padding(.leading, 5)
                .transition(referenceFadeUp)
            }
        }
        .frame(maxWidth: 380, minHeight: 176, alignment: .topLeading)
        .animation(referenceAnimation, value: isExpanded)
        .animation(referenceAnimation, value: phase)
        .task(id: variant) {
            await playSequence()
        }
    }

    @ViewBuilder
    private func thinkingRow(_ row: ReferenceThinkingRow, index: Int) -> some View {
        let isSelected = selectedCodingRow == row.primary

        Group {
            if variant == .search, let destination = row.destination {
                Link(destination: destination) {
                    rowContents(row, index: index)
                }
                .buttonStyle(.plain)
            } else if variant == .coding {
                Button {
                    selectedCodingRow = isSelected ? nil : row.primary
                } label: {
                    rowContents(row, index: index)
                }
                .buttonStyle(.plain)
                .background(isSelected ? theme.elevatedSurface : .clear, in: .rect(cornerRadius: 6))
            } else {
                rowContents(row, index: index)
            }
        }
        .accessibilityElement(children: .combine)
    }

    @ViewBuilder
    private func rowContents(_ row: ReferenceThinkingRow, index: Int) -> some View {
        HStack(spacing: 8) {
            if variant == .search {
                ReferenceThinkingGlobe(tint: [theme.accent, theme.warning, theme.positive][index % 3])
            } else if variant == .steps {
                if index < visibleRowCount - 1 || !isActive {
                    Image(systemName: "checkmark")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.tertiary)
                        .frame(width: 14, height: 14)
                } else {
                    ProgressView()
                        .controlSize(.mini)
                        .frame(width: 14, height: 14)
                }
            }

            Text(row.primary)
                .font(.system(size: 12.5, weight: variant == .reasoning ? .regular : .medium))
                .foregroundStyle(variant == .reasoning ? .secondary : .primary)
                .lineLimit(variant == .reasoning ? nil : 1)
                .lineSpacing(3)

            Spacer(minLength: 0)

            if let secondary = row.secondary {
                Text(secondary)
                    .font(row.isMonospaced ? .system(size: 11.5, design: .monospaced) : .system(size: 11.5))
                    .foregroundStyle(.tertiary)
                    .lineLimit(1)
            }

            if let additions = row.additions, let deletions = row.deletions {
                HStack(spacing: 4) {
                    Text("+\(additions)")
                        .foregroundStyle(theme.positive)
                    Text("−\(deletions)")
                        .foregroundStyle(theme.negative)
                }
                .font(.system(size: 11, design: .monospaced))
            }
        }
        .frame(minHeight: 28, alignment: .leading)
        .padding(.horizontal, 6)
        .padding(.vertical, 2)
        .contentShape(.rect)
    }

    private func playSequence() async {
        await MainActor.run {
            phase = reducesMotion ? 4 : 0
            expandedOverride = nil
            selectedCodingRow = nil
        }
        guard !reducesMotion else { return }

        for index in phaseDelays.indices.dropLast() {
            do {
                try await Task.sleep(for: .milliseconds(phaseDelays[index]))
            } catch {
                return
            }
            guard !Task.isCancelled else { return }
            await MainActor.run {
                withAnimation(referenceAnimation) {
                    phase = index + 1
                }
            }
        }
    }

    private var referenceAnimation: Animation {
        .timingCurve(0.23, 1, 0.32, 1, duration: 0.4)
    }

    private var referenceFadeUp: AnyTransition {
        .asymmetric(
            insertion: .opacity.combined(with: .offset(y: 6)),
            removal: .opacity
        )
    }
}

private struct ReferenceThinkingContent {
    let active: String
    let done: String
    let query: String?
    let rows: [ReferenceThinkingRow]

    static func forVariant(_ variant: ReferenceThinkingVariant) -> Self {
        switch variant {
        case .steps:
            .init(active: "Thinking", done: "Thought for 4 seconds", query: nil, rows: [
                .init(primary: "Reading flavor briefs"),
                .init(primary: "Scanning supplier lists"),
                .init(primary: "Comparing tasting notes", secondary: "6 flavors"),
                .init(primary: "Writing the scoop report")
            ])
        case .reasoning:
            .init(active: "Thinking", done: "Thought for 4 seconds", query: nil, rows: [
                .init(primary: "Summer demand spikes for stone-fruit flavors — peach and apricot lead."),
                .init(primary: "I should check cone inventory before promoting a waffle-bowl special.")
            ])
        case .search:
            .init(active: "Searching the web", done: "Searched the web", query: "best waffle cone supplier", rows: [
                .init(primary: "Joy Cone", secondary: "joycone.com", destination: URL(string: "https://joycone.com/fs_products/waffle-cones/")!),
                .init(primary: "WebstaurantStore", secondary: "webstaurantstore.com", destination: URL(string: "https://www.webstaurantstore.com/ice-cream-shop-supplies.html")!),
                .init(primary: "The Konery", secondary: "thekonery.com", destination: URL(string: "https://www.thekonery.com/")!)
            ])
        case .coding:
            .init(active: "Running tools", done: "Ran 3 tools", query: nil, rows: [
                .init(primary: "Read", secondary: "flavors.ts", isMonospaced: true),
                .init(primary: "Edit", secondary: "ChurnSchedule.tsx", isMonospaced: true, additions: 74, deletions: 41),
                .init(primary: "Run", secondary: "npm run freeze", isMonospaced: true)
            ])
        }
    }
}

private struct ReferenceThinkingRow: Identifiable {
    let id = UUID()
    let primary: String
    var secondary: String?
    var destination: URL?
    var isMonospaced = false
    var additions: Int?
    var deletions: Int?
}

private struct ReferenceThinkingSparkle: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        var path = Path()
        path.move(to: CGPoint(x: center.x, y: center.y - radius))
        path.addLine(to: CGPoint(x: center.x + radius * 0.3, y: center.y - radius * 0.3))
        path.addLine(to: CGPoint(x: center.x + radius, y: center.y))
        path.addLine(to: CGPoint(x: center.x + radius * 0.3, y: center.y + radius * 0.3))
        path.addLine(to: CGPoint(x: center.x, y: center.y + radius))
        path.addLine(to: CGPoint(x: center.x - radius * 0.3, y: center.y + radius * 0.3))
        path.addLine(to: CGPoint(x: center.x - radius, y: center.y))
        path.addLine(to: CGPoint(x: center.x - radius * 0.3, y: center.y - radius * 0.3))
        path.closeSubpath()
        return path
    }
}

private struct ReferenceThinkingGlobe: View {
    let tint: Color

    var body: some View {
        Circle()
            .fill(tint)
            .frame(width: 14, height: 14)
            .overlay {
                Image(systemName: "globe")
                    .font(.system(size: 8, weight: .bold))
                    .foregroundStyle(.white)
            }
    }
}
