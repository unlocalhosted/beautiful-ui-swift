import Foundation

public enum SelectionAction: String, CaseIterable, Identifiable, Sendable {
    case explain
    case improve
    case shorten
    case tone
    case grammar

    public var id: String { rawValue }

    public var title: String { rawValue.capitalized }

    public var symbolName: String {
        switch self {
        case .explain: "text.magnifyingglass"
        case .improve: "sparkles"
        case .shorten: "arrow.down.right.and.arrow.up.left"
        case .tone: "paintbrush"
        case .grammar: "textformat"
        }
    }
}
