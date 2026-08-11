import BeautifulUI
import SwiftUI

struct CatalogDetail: View {
    @Bindable var store: CatalogStore

    var body: some View {
        Group {
            if let section = store.selectedSection {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: BeautifulMetrics.section) {
                        CatalogNoticeBanner(notice: store.notice, onDismiss: dismissNotice)
                        CatalogHeader(section: section)
                        CatalogComponentPreview(section: section, store: store)
                    }
                    .frame(maxWidth: 800, alignment: .leading)
                    .padding(BeautifulMetrics.section)
                }
                .modifier(CatalogNavigationStyle())
            } else {
                ContentUnavailableView("Choose a component", systemImage: "square.grid.2x2")
            }
        }
    }

    private func dismissNotice() {
        store.notice = nil
    }
}
