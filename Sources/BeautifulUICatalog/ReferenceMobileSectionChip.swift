import SwiftUI

struct ReferenceMobileSectionChip: View {
    let section: CatalogSection
    let isSelected: Bool
    let action: () -> Void

    @Environment(\.beautifulTheme) private var theme

    var body: some View {
        Button(action: action) {
            Text(section.title)
                .font(.system(size: 11.5, weight: isSelected ? .medium : .regular))
                .foregroundStyle(isSelected ? .primary : .secondary)
                .padding(.horizontal, 9)
                .frame(height: 28)
                .background {
                    if isSelected {
                        Capsule().fill(theme.elevatedSurface)
                    }
                }
        }
        .buttonStyle(ReferencePlainButtonStyle())
    }
}
