import Foundation

public enum AgentTaskState: String, CaseIterable, Codable, Sendable {
    case queued
    case running
    case needsReview
    case completed
    case failed

    public var title: String {
        switch self {
        case .queued: "Queued"
        case .running: "Running"
        case .needsReview: "Needs review"
        case .completed: "Completed"
        case .failed: "Failed"
        }
    }

    public var symbolName: String {
        switch self {
        case .queued: "clock"
        case .running: "arrow.triangle.2.circlepath"
        case .needsReview: "exclamationmark.circle"
        case .completed: "checkmark.circle.fill"
        case .failed: "xmark.circle.fill"
        }
    }
}
