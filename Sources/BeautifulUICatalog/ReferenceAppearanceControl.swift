import SwiftUI

struct ReferenceAppearanceControl: View {
    @Binding var usesDarkAppearance: Bool

    @Environment(\.beautifulTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        HStack(spacing: 0) {
            ReferenceAppearanceButton(
                title: "Light mode",
                symbol: "sun.max.fill",
                isSelected: !usesDarkAppearance
            ) {
                usesDarkAppearance = false
            }
            ReferenceAppearanceButton(
                title: "Dark mode",
                symbol: "moon.fill",
                isSelected: usesDarkAppearance
            ) {
                usesDarkAppearance = true
            }
        }
        .padding(2)
        .background(theme.elevatedSurface, in: .capsule)
        .animation(reduceMotion ? nil : .easeOut(duration: 0.2), value: usesDarkAppearance)
    }
}
