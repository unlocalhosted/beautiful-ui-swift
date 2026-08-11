import SwiftUI

struct ReferenceFooterButtonStyle: ButtonStyle {
    @Environment(\.beautifulTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 10)
            .frame(height: 28)
            .background(theme.elevatedSurface, in: .capsule)
            .scaleEffect(configuration.isPressed && !reduceMotion ? 0.96 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}
