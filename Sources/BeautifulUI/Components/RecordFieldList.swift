import SwiftUI

struct RecordFieldList: View {
    let fields: [RecordField]

    var body: some View {
        ForEach(fields) { field in
            HStack(spacing: BeautifulMetrics.compact) {
                Text(field.title)
                    .font(.system(size: 11.5))
                    .foregroundStyle(.secondary)
                if field.tags.isEmpty {
                    Text(field.value)
                        .font(.system(size: 11.5))
                } else {
                    RecordTagList(tags: field.tags)
                }
            }
        }
    }
}
