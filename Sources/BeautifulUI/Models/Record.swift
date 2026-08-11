import Foundation

public struct Record: Identifiable, Equatable, Sendable {
    public let id: UUID
    public let title: String
    public let monogram: String
    public let fields: [RecordField]

    public init(id: UUID = UUID(), title: String, monogram: String, fields: [RecordField]) {
        self.id = id
        self.title = title
        self.monogram = monogram
        self.fields = fields
    }
}
