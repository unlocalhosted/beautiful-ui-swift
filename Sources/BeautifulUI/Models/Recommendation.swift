import Foundation

public struct Recommendation: Identifiable, Equatable, Sendable {
    public enum Confidence: String, CaseIterable, Codable, Sendable {
        case high
        case moderate
        case low

        public var title: String {
            switch self {
            case .high: "High confidence"
            case .moderate: "Moderate confidence"
            case .low: "Low confidence"
            }
        }
    }

    public let id: UUID
    public let title: String
    public let summary: String
    public let confidence: Confidence
    public let alternatives: [String]

    public init(
        id: UUID = UUID(),
        title: String,
        summary: String,
        confidence: Confidence,
        alternatives: [String] = []
    ) {
        self.id = id
        self.title = title
        self.summary = summary
        self.confidence = confidence
        self.alternatives = alternatives
    }
}
