import Foundation

public enum ApprovalDecision: Equatable, Sendable {
    case option(ApprovalOption)
    case custom(String)
}
