import BeautifulUI
import SwiftUI

struct ReferenceMobileCatalog: View {
    let store: CatalogStore
    @Binding var usesDarkAppearance: Bool

    var body: some View {
        @Bindable var store = store
        ScrollViewReader { proxy in
            ScrollView {
                ReferenceCatalogContent(store: store)
                    .padding(.horizontal, BeautifulMetrics.roomy)
                    .padding(.top, 88)
            }
            .scrollIndicators(.hidden)
            .safeAreaInset(edge: .top, spacing: 0) {
                ReferenceMobileHeader(
                    selectedSection: $store.selectedSection,
                    usesDarkAppearance: $usesDarkAppearance
                ) { section in
                    withAnimation(.easeInOut(duration: 0.22)) {
                        proxy.scrollTo(section, anchor: .top)
                    }
                }
            }
        }
    }
}
