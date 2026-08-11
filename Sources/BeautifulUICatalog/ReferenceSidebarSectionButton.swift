import SwiftUI

struct ReferenceSidebarSectionButton: View {
    let section: CatalogSection
    let isSelected: Bool
    let action: () -> Void

    @Environment(\.beautifulTheme) private var theme

    var body: some View {
        Button(action: action) {
            Text(section.title)
                .font(.system(size: 12.5, weight: isSelected ? .medium : .regular))
                .foregroundStyle(isSelected ? .primary : .secondary)
                .frame(maxWidth: .infinity, minHeight: 29, alignment: .leading)
                .padding(.horizontal, 8)
                .background {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 7)
                            .fill(theme.elevatedSurface)
                    }
                }
        }
        .buttonStyle(ReferencePlainButtonStyle())
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
