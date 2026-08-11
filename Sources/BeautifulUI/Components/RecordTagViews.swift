import SwiftUI

struct RecordTagViews: View {
    let tags: [String]

    var body: some View {
        ForEach(tags, id: \.self) { tag in
            Text(tag)
                .font(.system(size: 11))
                .padding(.horizontal, BeautifulMetrics.compact)
                .padding(.vertical, BeautifulMetrics.micro)
                .background(.quaternary, in: .rect(cornerRadius: 5))
        }
    }
}
