import Foundation

public struct FilterTask: Identifiable, Equatable, Sendable {
    public enum State: String, CaseIterable, Codable, Sendable {
        case todo
        case inProgress
        case completed

        public var title: String {
            switch self {
            case .todo: "To do"
            case .inProgress: "In progress"
            case .completed: "Completed"
            }
        }
    }

    public let id: UUID
    public let title: String
    public let date: Date
    public let advisor: String
    public var state: State

    public init(id: UUID = UUID(), title: String, date: Date, advisor: String, state: State) {
        self.id = id
        self.title = title
        self.date = date
        self.advisor = advisor
        self.state = state
    }
}
