import SwiftUI

struct ReferenceAppearanceButton: View {
    let title: String
    let symbol: String
    let isSelected: Bool
    let action: () -> Void

    @Environment(\.beautifulTheme) private var theme

    var body: some View {
        Button(action: action) {
            Image(systemName: symbol)
                .font(.system(size: 12, weight: .semibold))
                .frame(width: 32, height: 32)
                .foregroundStyle(isSelected ? .primary : .secondary)
                .background {
                    if isSelected {
                        Circle()
                            .fill(theme.surface)
                            .shadow(color: .black.opacity(0.18), radius: 1, y: 1)
                    }
                }
        }
        .buttonStyle(ReferencePlainButtonStyle())
        .accessibilityLabel(title)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
