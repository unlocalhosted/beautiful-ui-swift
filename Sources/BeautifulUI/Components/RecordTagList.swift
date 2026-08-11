import SwiftUI

struct RecordTagList: View {
    let tags: [String]

    var body: some View {
        ViewThatFits(in: .horizontal) {
            HStack(spacing: BeautifulMetrics.micro) {
                RecordTagViews(tags: tags)
            }
            FlowLayout(spacing: BeautifulMetrics.micro) {
                RecordTagViews(tags: tags)
            }
        }
    }
}
