import SwiftUI

struct WorkspaceDestinationButton: View {
    let destination: WorkspaceDestination
    let isSelected: Bool
    let action: () -> Void

    @Environment(\.beautifulTheme) private var theme

    var body: some View {
        Button(action: action) {
            Label(destination.title, systemImage: destination.symbolName)
                .font(.system(size: 12.5, weight: isSelected ? .medium : .regular))
                .foregroundStyle(isSelected ? .primary : .secondary)
                .frame(maxWidth: .infinity, minHeight: 30, alignment: .leading)
                .padding(.horizontal, 8)
                .background {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 7).fill(theme.elevatedSurface)
                    }
                }
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
