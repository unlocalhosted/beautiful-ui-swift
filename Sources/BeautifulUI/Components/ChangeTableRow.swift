import SwiftUI

struct ChangeTableRow: View {
    let change: RecordChange
    let columns: [String]

    var body: some View {
        GridRow {
            ForEach(change.values.indices, id: \.self) { index in
                Text(change.values[index])
                    .font(.system(size: 12.5))
                    .frame(minWidth: 120, alignment: .leading)
            }
        }
        .padding(BeautifulMetrics.regular)
        .background(backgroundColor)
        .accessibilityLabel("\(change.disposition.rawValue.capitalized) change")
    }

    @Environment(\.beautifulTheme) private var theme

    private var backgroundColor: Color {
        switch change.disposition {
        case .unchanged: .clear
        case .added: theme.positive.opacity(0.14)
        case .removed: theme.negative.opacity(0.14)
        case .modified: theme.warning.opacity(0.14)
        }
    }
}
