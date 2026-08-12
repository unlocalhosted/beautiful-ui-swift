import BeautifulUI
import SwiftUI

/// Native port of the reference `Context` primitive's staged source chips.
struct ReferenceContextDemo: View {
    @Environment(\.accessibilityReduceMotion) private var reducesMotion
    @Environment(\.beautifulTheme) private var theme
    @State private var showsSourceChips = false

    private static let chunks = [
        ReferenceContextChunk(
            title: "Vendor onboarding rule",
            characters: "290 characters",
            body: "Cold-chain certification must be verified before a new dairy can be added to the reorder workflow.",
            source: "Dairy Onboarding SOP.pdf",
            badge: "PDF",
            tint: .red
        ),
        ReferenceContextChunk(
            title: "Seasonal demand row",
            characters: "1,250 characters",
            body: "Q4 velocity table: pistachio +18%, vanilla +6%, rocky road -11%; retire flavors below 40 scoops weekly.",
            source: "Sales Velocity Export.csv",
            badge: "CSV",
            tint: .green
        )
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Text("All chunks")
                    .font(.system(size: 13, weight: .semibold))
                Text("32")
                    .font(.system(size: 11.5, weight: .medium))
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 6)
                    .frame(height: 20)
                    .background(theme.elevatedSurface, in: .rect(cornerRadius: 6))
            }
            .padding(.horizontal, 2)

            ForEach(Array(Self.chunks.enumerated()), id: \.element.id) { index, chunk in
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 6) {
                        Image(systemName: "text.alignleft")
                            .font(.system(size: 10, weight: .bold))
                        Text(chunk.title)
                            .font(.system(size: 13, weight: .medium))
                            .lineLimit(1)
                        Spacer(minLength: 0)
                        Text(chunk.characters)
                            .font(.system(size: 12))
                            .foregroundStyle(.tertiary)
                            .monospacedDigit()
                    }
                    .padding(.horizontal, 12)
                    .frame(height: 36)
                    .overlay(alignment: .bottom) { Rectangle().fill(theme.border).frame(height: 1) }

                    Text(chunk.body)
                        .font(.system(size: 12.5))
                        .foregroundStyle(.secondary)
                        .lineSpacing(3)
                        .padding(.horizontal, 12)
                        .padding(.top, 8)
                        .padding(.bottom, 4)

                    HStack(spacing: 6) {
                        Text(chunk.badge)
                            .font(.system(size: 7, weight: .black))
                            .foregroundStyle(.white)
                            .frame(width: 14, height: 14)
                            .background(chunk.tint, in: .rect(cornerRadius: 4))
                        Text(chunk.source)
                            .font(.system(size: 12, weight: .medium))
                        Image(systemName: "arrow.up.right")
                            .font(.system(size: 9, weight: .bold))
                    }
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 8)
                    .frame(height: 24)
                    .background(theme.elevatedSurface, in: .capsule)
                    .padding(.horizontal, 12)
                    .padding(.bottom, 12)
                    .opacity(showsSourceChips ? 1 : 0)
                    .scaleEffect(showsSourceChips ? 1 : 0.95, anchor: .leading)
                    .animation(.timingCurve(0.23, 1, 0.32, 1, duration: 0.3).delay(Double(index) * 0.08), value: showsSourceChips)
                }
                .background(theme.surface, in: .rect(cornerRadius: 12))
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(theme.border, lineWidth: 1))
                .transition(.opacity.combined(with: .offset(y: 6)))
            }
        }
        .frame(maxWidth: 380, alignment: .leading)
        .task {
            showsSourceChips = reducesMotion
            guard !reducesMotion else { return }
            try? await Task.sleep(for: .milliseconds(700))
            guard !Task.isCancelled else { return }
            withAnimation { showsSourceChips = true }
        }
    }
}

private struct ReferenceContextChunk: Identifiable {
    let title: String
    let characters: String
    let body: String
    let source: String
    let badge: String
    let tint: Color
    var id: String { source }
}
