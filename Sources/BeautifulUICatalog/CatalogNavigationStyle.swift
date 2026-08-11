import SwiftUI

struct CatalogNavigationStyle: ViewModifier {
    func body(content: Content) -> some View {
        #if os(iOS)
        content
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        #else
        content
            .navigationTitle("BeautifulUI")
        #endif
    }
}
