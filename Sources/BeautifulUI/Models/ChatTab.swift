import Foundation

public struct ChatTab: Identifiable, Equatable, Sendable {
    public let id: UUID
    public let title: String

    public init(id: UUID = UUID(), title: String) {
        self.id = id
        self.title = title
    }
}
