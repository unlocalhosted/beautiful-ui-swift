import Foundation

public struct ApprovalOption: Identifiable, Equatable, Sendable {
    public let id: UUID
    public let title: String
    public let detail: String?

    public init(id: UUID = UUID(), title: String, detail: String? = nil) {
        self.id = id
        self.title = title
        self.detail = detail
    }
}
