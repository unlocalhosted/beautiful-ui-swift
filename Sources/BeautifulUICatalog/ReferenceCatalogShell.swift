import BeautifulUI
import SwiftUI

struct ReferenceCatalogShell: View {
    let store: CatalogStore

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var usesDarkAppearance = true

    var body: some View {
        let theme = usesDarkAppearance ? BeautifulTheme.reference : BeautifulTheme.referenceLight
        ZStack {
            theme.sidebar
                .ignoresSafeArea()
            if horizontalSizeClass == .compact {
                ReferenceMobileCatalog(store: store, usesDarkAppearance: $usesDarkAppearance)
            } else {
                ReferenceDesktopCatalog(store: store, usesDarkAppearance: $usesDarkAppearance)
            }
        }
        .environment(\.beautifulTheme, theme)
        .preferredColorScheme(usesDarkAppearance ? .dark : .light)
        .tint(theme.accent)
    }
}
