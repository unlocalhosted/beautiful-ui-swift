import BeautifulUI
import SwiftUI

struct ReferenceCatalogContent: View {
    let store: CatalogStore

    var body: some View {
        LazyVStack(alignment: .leading, spacing: 0) {
            ForEach(CatalogSection.allCases) { section in
                ReferenceShowcase(section: section, store: store)
                    .id(section)
            }
            ReferenceCatalogFooter()
        }
    }
}
