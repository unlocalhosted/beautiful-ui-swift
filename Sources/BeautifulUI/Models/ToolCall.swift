import Foundation

public struct ToolCall: Identifiable, Equatable, Sendable {
    public enum Kind: String, CaseIterable, Codable, Sendable {
        case thinking
        case read
        case write
        case command
        case message

        public var symbolName: String {
            switch self {
            case .thinking: "sparkles"
            case .read: "doc.text"
            case .write: "pencil"
            case .command: "terminal"
            case .message: "bubble"
            }
        }
    }

    public let id: UUID
    public let kind: Kind
    public let title: String
    public let detail: String?

    public init(id: UUID = UUID(), kind: Kind, title: String, detail: String? = nil) {
        self.id = id
        self.kind = kind
        self.title = title
        self.detail = detail
    }
}
