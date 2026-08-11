import Foundation

public struct RecordField: Identifiable, Equatable, Sendable {
    public let id: UUID
    public let title: String
    public let value: String
    public let tags: [String]

    public init(id: UUID = UUID(), title: String, value: String, tags: [String] = []) {
        self.id = id
        self.title = title
        self.value = value
        self.tags = tags
    }
}
