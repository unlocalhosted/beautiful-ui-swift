import BeautifulUI
import SwiftUI

struct CatalogLoadingDemo: View {
    @Binding var style: LoadingStyle

    var body: some View {
        LoadingStateView(label: "Churning", startedAt: .now, style: style)
    }
}
