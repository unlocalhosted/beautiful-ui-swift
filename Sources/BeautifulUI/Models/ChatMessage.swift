import Foundation

public struct ChatMessage: Identifiable, Equatable, Sendable {
    public enum Role: String, Codable, Sendable {
        case user
        case assistant
    }

    public let id: UUID
    public let role: Role
    public let text: String
    public let metadata: String?

    public init(id: UUID = UUID(), role: Role, text: String, metadata: String? = nil) {
        self.id = id
        self.role = role
        self.text = text
        self.metadata = metadata
    }
}
