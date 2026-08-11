import Foundation

public struct ApprovalRequest: Identifiable, Equatable, Sendable {
    public let id: UUID
    public let prompt: String
    public let options: [ApprovalOption]
    public let allowsCustomResponse: Bool

    public init(
        id: UUID = UUID(),
        prompt: String,
        options: [ApprovalOption],
        allowsCustomResponse: Bool = true
    ) {
        self.id = id
        self.prompt = prompt
        self.options = options
        self.allowsCustomResponse = allowsCustomResponse
    }
}
