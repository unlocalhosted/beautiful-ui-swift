import SwiftUI

/// Shared color and shape decisions for BeautifulUI components.
public struct BeautifulTheme: Sendable {
    public var accent: Color
    public var positive: Color
    public var warning: Color
    public var negative: Color
    public var canvas: Color
    public var sidebar: Color
    public var surface: Color
    public var elevatedSurface: Color
    public var border: Color

    public init(
        accent: Color = .indigo,
        positive: Color = .green,
        warning: Color = .orange,
        negative: Color = .red,
        canvas: Color = Color(red: 0.09, green: 0.09, blue: 0.10),
        sidebar: Color = Color(red: 0.10, green: 0.10, blue: 0.11),
        surface: Color = Color(red: 0.13, green: 0.13, blue: 0.15),
        elevatedSurface: Color = Color(red: 0.16, green: 0.16, blue: 0.18),
        border: Color = Color.white.opacity(0.10)
    ) {
        self.accent = accent
        self.positive = positive
        self.warning = warning
        self.negative = negative
        self.canvas = canvas
        self.sidebar = sidebar
        self.surface = surface
        self.elevatedSurface = elevatedSurface
        self.border = border
    }

    /// Exact low-contrast palette used by the reference catalogue.
    public static let reference = BeautifulTheme(
        accent: Color(red: 0.24, green: 0.60, blue: 1),
        positive: Color(red: 0.24, green: 0.73, blue: 0.45),
        warning: Color(red: 0.96, green: 0.56, blue: 0.24),
        negative: Color(red: 0.93, green: 0.36, blue: 0.38),
        canvas: Color(red: 0.110, green: 0.114, blue: 0.122),
        sidebar: Color(red: 0.090, green: 0.094, blue: 0.102),
        surface: Color(red: 0.137, green: 0.141, blue: 0.153),
        elevatedSurface: Color(red: 0.122, green: 0.125, blue: 0.133),
        border: Color(red: 0.180, green: 0.188, blue: 0.200)
    )

    /// Exact light counterpart used by the original reference catalogue.
    public static let referenceLight = BeautifulTheme(
        accent: Color(red: 0.008, green: 0.522, blue: 1),
        positive: Color(red: 0.094, green: 0.604, blue: 0.302),
        warning: Color(red: 0.937, green: 0.447, blue: 0.047),
        negative: Color(red: 0.890, green: 0.278, blue: 0.298),
        canvas: Color(red: 0.945, green: 0.949, blue: 0.953),
        sidebar: Color(red: 0.980, green: 0.980, blue: 0.984),
        surface: .white,
        elevatedSurface: Color(red: 0.969, green: 0.973, blue: 0.976),
        border: Color(red: 0.925, green: 0.929, blue: 0.937)
    )

    /// Default presentation for applications that do not supply a theme.
    public static let standard = BeautifulTheme.reference
}

public extension EnvironmentValues {
    @Entry var beautifulTheme = BeautifulTheme.standard
}
