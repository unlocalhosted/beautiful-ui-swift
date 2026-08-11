import Foundation

public struct AgentTask: Identifiable, Equatable, Sendable {
    public let id: UUID
    public var title: String
    public var detail: String
    public var state: AgentTaskState
    public var progress: Double?
    public var quantityLabel: String?

    public init(
        id: UUID = UUID(),
        title: String,
        detail: String,
        state: AgentTaskState,
        progress: Double? = nil,
        quantityLabel: String? = nil
    ) {
        self.id = id
        self.title = title
        self.detail = detail
        self.state = state
        self.progress = progress
        self.quantityLabel = quantityLabel
    }
}
