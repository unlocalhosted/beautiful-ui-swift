import SwiftUI

/// A horizontally adaptive table for agent-proposed changes.
public struct ChangeTable: View {
    public let title: String
    public let columns: [String]
    public let changes: [RecordChange]

    public init(title: String, columns: [String], changes: [RecordChange]) {
        self.title = title
        self.columns = columns
        self.changes = changes
    }

    public var body: some View {
        BeautifulSurface(padding: 0) {
            ScrollView(.horizontal) {
                Grid(alignment: .leading, horizontalSpacing: BeautifulMetrics.section, verticalSpacing: 0) {
                    GridRow {
                        ForEach(columns, id: \.self) { column in
                            Text(column)
                                .font(.system(size: 11.5, weight: .medium))
                                .foregroundStyle(.secondary)
                                .frame(minWidth: 120, alignment: .leading)
                        }
                    }
                    .padding(BeautifulMetrics.regular)
                    ForEach(changes) { change in
                        ChangeTableRow(change: change, columns: columns)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .accessibilityLabel(title)
        }
    }
}

#Preview {
    ChangeTable(
        title: "Proposed menu cleanup",
        columns: ["Flavor", "Category", "Supplier"],
        changes: [.init(values: ["Rocky Road", "Classic", "aurora-scoops"], disposition: .removed), .init(values: ["Pistachio", "Seasonal", "maple-orbit"], disposition: .added)]
    )
    .padding()
}
