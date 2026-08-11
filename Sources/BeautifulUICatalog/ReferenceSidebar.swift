import BeautifulUI
import SwiftUI

struct ReferenceSidebar: View {
    let selectedSection: CatalogSection?
    @Binding var usesDarkAppearance: Bool
    let onSelect: (CatalogSection) -> Void

    @Environment(\.beautifulTheme) private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ReferenceSidebarBrand(usesDarkAppearance: $usesDarkAppearance)
            ReferenceSidebarNavigation(
                selectedSection: selectedSection,
                onSelect: onSelect
            )
            Spacer(minLength: 20)
            ReferenceSidebarFooter()
        }
        .padding(.horizontal, 28)
        .padding(.top, 52)
        .padding(.bottom, 28)
        .frame(width: 288)
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .background(theme.sidebar)
        .overlay(alignment: .trailing) {
            Rectangle()
                .stroke(theme.border, style: StrokeStyle(lineWidth: 1, dash: [3, 3]))
                .frame(width: 1)
        }
    }
}
