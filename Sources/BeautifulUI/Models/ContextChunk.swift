import Foundation

public struct ContextChunk: Identifiable, Equatable, Sendable {
    public enum SourceKind: String, CaseIterable, Codable, Sendable {
        case document
        case spreadsheet
        case webpage
        case note

        public var symbolName: String {
            switch self {
            case .document: "doc.text"
            case .spreadsheet: "tablecells"
            case .webpage: "globe"
            case .note: "note.text"
            }
        }
    }

    public let id: UUID
    public let title: String
    public let excerpt: String
    public let sourceName: String
    public let sourceKind: SourceKind
    public let characterCount: Int

    public init(
        id: UUID = UUID(),
        title: String,
        excerpt: String,
        sourceName: String,
        sourceKind: SourceKind,
        characterCount: Int
    ) {
        self.id = id
        self.title = title
        self.excerpt = excerpt
        self.sourceName = sourceName
        self.sourceKind = sourceKind
        self.characterCount = characterCount
    }
}
