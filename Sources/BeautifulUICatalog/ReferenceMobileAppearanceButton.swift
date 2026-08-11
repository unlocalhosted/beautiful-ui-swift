import SwiftUI

struct ReferenceMobileAppearanceButton: View {
    @Binding var usesDarkAppearance: Bool

    @Environment(\.beautifulTheme) private var theme

    var body: some View {
        Button {
            usesDarkAppearance.toggle()
        } label: {
            Image(systemName: usesDarkAppearance ? "moon.fill" : "sun.max.fill")
                .font(.system(size: 13, weight: .semibold))
                .frame(width: 40, height: 40)
                .foregroundStyle(.primary)
                .background(theme.elevatedSurface, in: .circle)
        }
        .buttonStyle(ReferencePlainButtonStyle())
        .accessibilityLabel(usesDarkAppearance ? "Switch to light mode" : "Switch to dark mode")
    }
}
