import Foundation

public struct CodeSnippet: Identifiable, Equatable, Sendable {
    public let id: UUID
    public let filename: String
    public let language: String
    public let source: String

    public init(id: UUID = UUID(), filename: String, language: String, source: String) {
        self.id = id
        self.filename = filename
        self.language = language
        self.source = source
    }
}
