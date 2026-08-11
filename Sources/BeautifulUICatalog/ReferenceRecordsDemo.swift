import BeautifulUI
import SwiftUI

/// Native port of the reference `Records` primitive: selectable, sortable, and horizontally scrollable.
struct ReferenceRecordsDemo: View {
    private enum SortKey { case name, last, strength }

    @Environment(\.beautifulTheme) private var theme
    @State private var selectedIDs: Set<String> = []
    @State private var sortKey: SortKey = .name
    @State private var isAscending = true

    private let records = [
        ReferenceRecord(id: "aurora", name: "Aurora Scoops — Reykjavík", tags: ["Gelato", "Seasonal"], last: "9 days ago", strength: .strong, website: "aurora-scoops.example.com"),
        ReferenceRecord(id: "kumo", name: "Kumo Creamery — Tokyo", tags: ["B2C", "Cafe", "Vegan"], last: "3 weeks ago", strength: .strong, website: "kumo-creamery.example.com"),
        ReferenceRecord(id: "sol-nieve", name: "Sol y Nieve — Buenos Aires", tags: ["Gelato", "Local"], last: "2 months ago", strength: .weak, website: "sol-y-nieve.example.com"),
        ReferenceRecord(id: "maple-orbit", name: "Maple Orbit — Montréal", tags: ["B2B", "Wholesale", "Seasonal"], last: "15 days ago", strength: .weak, website: "maple-orbit.example.com"),
        ReferenceRecord(id: "blue-fig", name: "Blue Fig Gelato — Florence", tags: ["Gelato", "Cafe"], last: "over 1 year ago", strength: .veryWeak, website: "blue-fig.example.com"),
        ReferenceRecord(id: "sahara-swirl", name: "Sahara Swirl — Marrakech", tags: ["Sorbet", "Local"], last: "5 months ago", strength: .veryWeak, website: nil),
        ReferenceRecord(id: "cloudberry", name: "Cloudberry Cone — Helsinki", tags: ["Dairy-free", "Seasonal"], last: "No contact", strength: .none, website: "cloudberry-cone.example.com")
    ]

    private var sortedRecords: [ReferenceRecord] {
        records.sorted { left, right in
            let result: Bool
            switch sortKey {
            case .name: result = left.name.localizedCaseInsensitiveCompare(right.name) == .orderedAscending
            case .last: result = left.last.localizedCaseInsensitiveCompare(right.last) == .orderedAscending
            case .strength: result = left.strength.rank < right.strength.rank
            }
            return isAscending ? result : !result
        }
    }

    var body: some View {
        ScrollView([.horizontal, .vertical], showsIndicators: true) {
            VStack(spacing: 0) {
                recordHeader
                ForEach(sortedRecords) { record in
                    recordRow(record)
                }
                calculationRow
            }
            .frame(minWidth: 760, alignment: .leading)
        }
        .frame(maxWidth: 480, minHeight: 300, maxHeight: 360)
        .background(theme.surface, in: .rect(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(theme.border, lineWidth: 1))
        .accessibilityLabel("Companies table. Scroll horizontally and vertically to view all columns and records.")
    }

    private var recordHeader: some View {
        HStack(spacing: 0) {
            HStack(spacing: 8) {
                selectionBox(isSelected: selectedIDs.count == records.count)
                    .onTapGesture { selectedIDs = selectedIDs.count == records.count ? [] : Set(records.map(\.id)) }
                Text("Company")
            }
            .frame(width: 230, alignment: .leading)
            headerButton("Categories", icon: "tag", key: .name).frame(width: 190, alignment: .leading)
            headerButton("Last interaction", icon: "arrow.down.to.line", key: .last).frame(width: 125, alignment: .leading)
            headerButton("Connection strength", icon: "heart", key: .strength).frame(width: 150, alignment: .leading)
            HStack(spacing: 6) { Image(systemName: "link"); Text("Links") }
                .frame(width: 160, alignment: .leading)
        }
        .font(.system(size: 11.5, weight: .medium))
        .foregroundStyle(.tertiary)
        .padding(.horizontal, 12)
        .frame(height: 40)
        .overlay(alignment: .bottom) { Rectangle().fill(theme.border).frame(height: 1) }
    }

    private func headerButton(_ title: String, icon: String, key: SortKey) -> some View {
        Button {
            if sortKey == key { isAscending.toggle() }
            else { sortKey = key; isAscending = true }
        } label: {
            HStack(spacing: 6) {
                Image(systemName: icon).font(.system(size: 12, weight: .medium))
                Text(title)
                Image(systemName: "arrow.down")
                    .font(.system(size: 10, weight: .bold))
                    .opacity(sortKey == key ? 1 : 0)
                    .rotationEffect(.degrees(isAscending ? 0 : 180))
            }
        }
        .buttonStyle(.plain)
    }

    private func recordRow(_ record: ReferenceRecord) -> some View {
        let isSelected = selectedIDs.contains(record.id)
        return HStack(spacing: 0) {
            HStack(spacing: 8) {
                selectionBox(isSelected: isSelected)
                    .onTapGesture { toggleSelection(record.id) }
                Text(record.name.prefix(1))
                    .font(.system(size: 12, weight: .bold))
                    .frame(width: 22, height: 22)
                    .background(theme.elevatedSurface, in: .rect(cornerRadius: 6))
                Text(record.name).font(.system(size: 12.5, weight: .medium)).lineLimit(1)
            }
            .frame(width: 230, alignment: .leading)

            HStack(spacing: 4) {
                ForEach(record.tags.prefix(3), id: \.self) { tag in ReferenceRecordTag(tag: tag) }
            }
            .frame(width: 190, alignment: .leading)

            Text(record.last).font(.system(size: 12)).foregroundStyle(record.last == "No contact" ? Color.secondary.opacity(0.65) : Color.secondary).frame(width: 125, alignment: .leading)

            HStack(spacing: 6) {
                Circle().fill(record.strength.color).frame(width: 7, height: 7)
                Text(record.strength.label)
            }
            .font(.system(size: 12))
            .foregroundStyle(.secondary)
            .frame(width: 150, alignment: .leading)

            Group {
                if let website = record.website {
                    Link(destination: URL(string: "https://\(website)")!) {
                        HStack(spacing: 4) {
                            Text(website).lineLimit(1)
                            Image(systemName: "arrow.up.right").font(.system(size: 10, weight: .bold))
                        }
                    }
                } else {
                    Text("—").foregroundStyle(.tertiary)
                }
            }
            .font(.system(size: 11.5))
            .foregroundStyle(theme.accent)
            .frame(width: 160, alignment: .leading)
        }
        .padding(.horizontal, 12)
        .frame(height: 42)
        .background(isSelected ? theme.accent.opacity(0.10) : .clear)
        .overlay(alignment: .bottom) { Rectangle().fill(theme.border).frame(height: 1) }
    }

    private var calculationRow: some View {
        HStack(spacing: 0) {
            Text("\(records.count) count")
                .frame(width: 230, alignment: .leading)
            Button { } label: { Label("Add calculation", systemImage: "plus") }
                .frame(width: 190, alignment: .leading)
            Text("—").frame(width: 125, alignment: .leading)
            HStack(spacing: 6) {
                Circle().fill(theme.warning).frame(width: 7, height: 7)
                Text("\(averageStrength)% average")
            }
            .frame(width: 150, alignment: .leading)
            Text("\(records.compactMap(\.website).count) links")
                .frame(width: 160, alignment: .leading)
        }
        .font(.system(size: 12))
        .foregroundStyle(.secondary)
        .padding(.horizontal, 12)
        .frame(height: 40)
    }

    private func selectionBox(isSelected: Bool) -> some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(isSelected ? theme.accent : .clear)
            .frame(width: 16, height: 16)
            .overlay {
                RoundedRectangle(cornerRadius: 4).stroke(isSelected ? .clear : theme.border, lineWidth: 1.5)
                if isSelected { Image(systemName: "checkmark").font(.system(size: 9, weight: .black)).foregroundStyle(.white) }
            }
    }

    private func toggleSelection(_ id: String) {
        if selectedIDs.contains(id) { selectedIDs.remove(id) }
        else { selectedIDs.insert(id) }
    }

    private var averageStrength: Int {
        Int((Double(records.map { $0.strength.rank }.reduce(0, +)) / Double(records.count) / 3 * 100).rounded())
    }
}

private struct ReferenceRecord: Identifiable {
    let id: String
    let name: String
    let tags: [String]
    let last: String
    let strength: ReferenceConnectionStrength
    let website: String?
}

private enum ReferenceConnectionStrength {
    case strong, weak, veryWeak, none
    var rank: Int { switch self { case .strong: 3; case .weak: 2; case .veryWeak: 1; case .none: 0 } }
    var label: String { switch self { case .strong: "Very strong"; case .weak: "Weak"; case .veryWeak: "Very weak"; case .none: "No communication" } }
    var color: Color { switch self { case .strong: .green; case .weak: .orange; case .veryWeak: .red; case .none: .secondary } }
}

private struct ReferenceRecordTag: View {
    let tag: String
    private var tint: Color {
        switch tag {
        case "B2B", "Seasonal": .orange
        case "B2C", "Vegan": .green
        case "Cafe": .pink
        case "Dairy-free", "Sorbet": .cyan
        case "Gelato": .purple
        case "Wholesale": .blue
        default: .secondary
        }
    }
    var body: some View {
        HStack(spacing: 4) {
            Circle().fill(tint).frame(width: 5, height: 5)
            Text(tag)
        }
        .font(.system(size: 10.5, weight: .medium))
        .foregroundStyle(.secondary)
        .padding(.horizontal, 6)
        .frame(height: 20)
        .background(Color.secondary.opacity(0.1), in: .capsule)
    }
}
