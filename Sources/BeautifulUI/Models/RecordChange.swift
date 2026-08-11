import Foundation

public struct RecordChange: Identifiable, Equatable, Sendable {
    public enum Disposition: String, CaseIterable, Codable, Sendable {
        case unchanged
        case added
        case removed
        case modified
    }

    public let id: UUID
    public let values: [String]
    public let disposition: Disposition

    public init(id: UUID = UUID(), values: [String], disposition: Disposition) {
        self.id = id
        self.values = values
        self.disposition = disposition
    }
}
