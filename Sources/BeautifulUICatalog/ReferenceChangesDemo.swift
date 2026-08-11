import BeautifulUI
import SwiftUI

/// Native port of the reference `Changes` primitive's removal/addition sequence.
struct ReferenceChangesDemo: View {
    @Environment(\.accessibilityReduceMotion) private var reducesMotion
    @Environment(\.beautifulTheme) private var theme
    @State private var stage = 0

    private let rows = [
        ReferenceChangeRow(name: "Rocky Road", category: "Classic", supplier: "aurora-scoops", isRemoved: true),
        ReferenceChangeRow(name: "Bubblegum", category: "Retro", supplier: "kumo-creamery", isRemoved: true),
        ReferenceChangeRow(name: "Mint Chip", category: "Classic", supplier: "maple-orbit", isRemoved: false)
    ]

    var body: some View {
        VStack(spacing: 0) {
            Text("Proposed menu cleanup")
                .font(.system(size: 12.5, weight: .medium))
                .frame(maxWidth: .infinity, minHeight: 36, maxHeight: 36, alignment: .leading)
                .padding(.horizontal, 12)
                .overlay(alignment: .bottom) { Rectangle().fill(theme.border).frame(height: 1) }

            HStack(spacing: 0) {
                header("Flavor").frame(maxWidth: .infinity, alignment: .leading)
                header("Category").frame(maxWidth: .infinity, alignment: .leading)
                header("Supplier").frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 12)
            .frame(height: 32)
            .overlay(alignment: .bottom) { Rectangle().fill(theme.border).frame(height: 1) }

            ForEach(rows) { row in
                changeRow(row)
            }

            if stage >= 3 {
                HStack(spacing: 0) {
                    Text("Pistachio")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(theme.positive)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    category("Seasonal", dot: theme.positive)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("maple-orbit")
                        .font(.system(size: 13))
                        .foregroundStyle(theme.positive)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 12)
                .frame(height: 40)
                .background(theme.positive.opacity(0.14))
                .overlay(alignment: .top) { Rectangle().fill(theme.border).frame(height: 1) }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .frame(maxWidth: 380, alignment: .leading)
        .background(theme.surface, in: .rect(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(theme.border, lineWidth: 1))
        .shadow(color: .black.opacity(0.15), radius: 9, y: 3)
        .animation(.timingCurve(0.23, 1, 0.32, 1, duration: 0.4), value: stage)
        .task { await playChanges() }
    }

    private func changeRow(_ row: ReferenceChangeRow) -> some View {
        let isRemoved = row.isRemoved && stage >= 2
        return HStack(spacing: 0) {
            Text(row.name)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(isRemoved ? theme.negative : Color.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
            category(row.category, dot: row.category == "Classic" ? theme.accent : .secondary)
                .opacity(isRemoved ? 0.55 : 1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(row.supplier)
                .font(.system(size: 12.5))
                .foregroundStyle(isRemoved ? theme.negative : Color.secondary)
                .strikethrough(isRemoved, color: theme.negative.opacity(0.5))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 12)
        .frame(height: 40)
        .background(isRemoved ? theme.negative.opacity(0.14) : .clear)
        .overlay(alignment: .bottom) { Rectangle().fill(theme.border).frame(height: 1) }
    }

    private func header(_ text: String) -> some View {
        Text(text).font(.system(size: 12, weight: .medium)).foregroundStyle(.tertiary)
    }

    private func category(_ name: String, dot: Color) -> some View {
        HStack(spacing: 6) {
            Circle().fill(dot).frame(width: 6, height: 6)
            Text(name).font(.system(size: 11.5, weight: .medium)).foregroundStyle(.secondary)
        }
        .padding(.horizontal, 8)
        .frame(height: 22)
        .background(theme.elevatedSurface, in: .capsule)
        .overlay(Capsule().stroke(theme.border, lineWidth: 1))
    }

    private func playChanges() async {
        await MainActor.run { stage = reducesMotion ? 3 : 0 }
        guard !reducesMotion else { return }
        for delay in [800, 1_000, 1_000] {
            do { try await Task.sleep(for: .milliseconds(delay)) }
            catch { return }
            await MainActor.run { stage += 1 }
        }
    }
}

private struct ReferenceChangeRow: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let supplier: String
    let isRemoved: Bool
}
