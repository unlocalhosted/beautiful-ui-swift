import SwiftUI

public struct BeautifulSecondaryButtonStyle: ButtonStyle {
    @Environment(\.beautifulTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 12, weight: .medium))
            .foregroundStyle(.primary)
            .padding(.horizontal, 10)
            .frame(minHeight: BeautifulMetrics.controlHeight)
            .background(theme.elevatedSurface, in: .rect(cornerRadius: 8))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(theme.border, lineWidth: 1)
            }
            .opacity(configuration.isPressed ? 0.86 : 1)
            .scaleEffect(configuration.isPressed && !reduceMotion ? 0.96 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

public struct BeautifulPrimaryButtonStyle: ButtonStyle {
    @Environment(\.beautifulTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 12, weight: .medium))
            .foregroundStyle(theme.canvas)
            .padding(.horizontal, 10)
            .frame(minHeight: BeautifulMetrics.controlHeight)
            .background(.primary, in: .rect(cornerRadius: 8))
            .opacity(configuration.isPressed ? 0.86 : 1)
            .scaleEffect(configuration.isPressed && !reduceMotion ? 0.96 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

public struct BeautifulIconButtonStyle: ButtonStyle {
    @Environment(\.beautifulTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 12, weight: .medium))
            .foregroundStyle(.secondary)
            .frame(width: 28, height: 28)
            .background {
                if configuration.isPressed {
                    RoundedRectangle(cornerRadius: 6).fill(theme.elevatedSurface)
                }
            }
            .scaleEffect(configuration.isPressed && !reduceMotion ? 0.96 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}
