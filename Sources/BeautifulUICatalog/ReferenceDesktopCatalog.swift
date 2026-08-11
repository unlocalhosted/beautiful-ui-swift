import BeautifulUI
import SwiftUI

struct ReferenceDesktopCatalog: View {
    let store: CatalogStore
    @Binding var usesDarkAppearance: Bool

    @Environment(\.beautifulTheme) private var theme

    var body: some View {
        @Bindable var store = store
        ScrollViewReader { proxy in
            HStack(spacing: 0) {
                ReferenceSidebar(
                    selectedSection: store.selectedSection,
                    usesDarkAppearance: $usesDarkAppearance
                ) { section in
                    store.selectedSection = section
                    withAnimation(.easeInOut(duration: 0.22)) {
                        proxy.scrollTo(section, anchor: .top)
                    }
                }
                ScrollView {
                    ReferenceCatalogContent(store: store)
                }
                .scrollIndicators(.hidden)
            }
            .frame(maxWidth: 960, maxHeight: .infinity, alignment: .topLeading)
            .overlay {
                Rectangle()
                    .stroke(theme.border, lineWidth: 1)
                    .allowsHitTesting(false)
            }
        }
    }
}
