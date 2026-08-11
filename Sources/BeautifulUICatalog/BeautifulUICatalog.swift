import BeautifulUI
import SwiftUI

/// Native component catalogue. It is intentionally local-only: all effects are represented as visible demo notices.
public struct BeautifulUICatalog: View {
    @State private var store = CatalogStore()

    public init() {}

    public var body: some View {
        ReferenceCatalogShell(store: store)
    }
}

#Preview {
    BeautifulUICatalog()
}
