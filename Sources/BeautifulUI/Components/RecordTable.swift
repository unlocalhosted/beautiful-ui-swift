import SwiftUI

/// Cross-platform records view; list treatment stays legible on narrow iPhone widths.
public struct RecordTable: View {
    public let records: [Record]
    public let onSelect: (Record) -> Void

    public init(records: [Record], onSelect: @escaping (Record) -> Void = { _ in }) {
        self.records = records
        self.onSelect = onSelect
    }

    public var body: some View {
        BeautifulSurface(padding: BeautifulMetrics.compact) {
            if records.isEmpty {
                Text("No records")
                    .font(.system(size: 12.5))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding(BeautifulMetrics.section)
            } else {
                LazyVStack(spacing: BeautifulMetrics.micro) {
                    ForEach(records) { record in
                        Button(action: { onSelect(record) }) {
                            RecordTableRow(record: record)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
}

#Preview {
    RecordTable(records: [.init(title: "Aurora Scoops — Reykjavík", monogram: "A", fields: [.init(title: "Categories", value: "Gelato", tags: ["Gelato", "Seasonal"]), .init(title: "Strength", value: "Very strong")])])
        .padding()
}
