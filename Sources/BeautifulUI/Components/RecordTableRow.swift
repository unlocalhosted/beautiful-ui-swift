import SwiftUI

struct RecordTableRow: View {
    let record: Record

    var body: some View {
        HStack(alignment: .top, spacing: BeautifulMetrics.regular) {
            Text(record.monogram)
                .font(.system(size: 11.5, weight: .semibold))
                .frame(width: 24, height: 24)
                .background(.quaternary, in: .rect(cornerRadius: 6))
            VStack(alignment: .leading, spacing: BeautifulMetrics.compact) {
                Text(record.title)
                    .font(.system(size: 12.5, weight: .medium))
                RecordFieldList(fields: record.fields)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(.tertiary)
        }
        .padding(BeautifulMetrics.regular)
        .contentShape(.rect)
        .accessibilityElement(children: .combine)
    }
}
