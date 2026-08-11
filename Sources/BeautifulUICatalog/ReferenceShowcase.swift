import BeautifulUI
import SwiftUI

struct ReferenceShowcase: View {
    let section: CatalogSection
    let store: CatalogStore

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ReferenceShowcaseHeader(section: section)
                .padding(.bottom, 12)
            CatalogComponentPreview(section: section, store: store)
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 40)
        .overlay(alignment: .bottom) {
            Rectangle()
                .stroke(
                    BeautifulTheme.reference.border,
                    style: StrokeStyle(lineWidth: 1, dash: [3, 3])
                )
                .frame(height: 1)
        }
        .scrollTargetLayout()
    }
}
