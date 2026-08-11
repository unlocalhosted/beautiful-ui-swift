import Foundation

public struct FineTuneValues: Equatable, Sendable {
    public enum Layout: String, CaseIterable, Codable, Sendable {
        case row
        case column
        case grid

        public var symbolName: String {
            switch self {
            case .row: "rectangle.split.3x1"
            case .column: "rectangle.split.1x3"
            case .grid: "square.grid.2x2"
            }
        }
    }

    public var layout: Layout
    public var width: Double
    public var height: Double
    public var cornerRadius: Double
    public var opacity: Double

    public init(
        layout: Layout = .row,
        width: Double = 324,
        height: Double = 96,
        cornerRadius: Double = 28,
        opacity: Double = 1
    ) {
        self.layout = layout
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.opacity = opacity
    }
}
