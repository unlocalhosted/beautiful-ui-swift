import Foundation

public struct ResponseAction: Identifiable, Equatable, Sendable {
    public let id: UUID
    public let title: String
    public let symbolName: String

    public init(id: UUID = UUID(), title: String, symbolName: String) {
        self.id = id
        self.title = title
        self.symbolName = symbolName
    }
}
