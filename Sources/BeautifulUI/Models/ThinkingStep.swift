import Foundation

public struct ThinkingStep: Identifiable, Equatable, Sendable {
    public enum Kind: String, CaseIterable, Codable, Sendable {
        case planning
        case reasoning
        case search
        case coding

        public var symbolName: String {
            switch self {
            case .planning: "point.3.connected.trianglepath.dotted"
            case .reasoning: "sparkles"
            case .search: "magnifyingglass"
            case .coding: "chevron.left.forwardslash.chevron.right"
            }
        }
    }

    public let id: UUID
    public let kind: Kind
    public let title: String
    public let detail: String
    public let duration: Duration?

    public init(
        id: UUID = UUID(),
        kind: Kind,
        title: String,
        detail: String,
        duration: Duration? = nil
    ) {
        self.id = id
        self.kind = kind
        self.title = title
        self.detail = detail
        self.duration = duration
    }
}
