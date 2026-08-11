import Foundation

public struct Insight: Identifiable, Equatable, Sendable {
    public struct Metric: Identifiable, Equatable, Sendable {
        public let id: UUID
        public let name: String
        public let delta: Double
        public let amount: Double

        public init(id: UUID = UUID(), name: String, delta: Double, amount: Double) {
            self.id = id
            self.name = name
            self.delta = delta
            self.amount = amount
        }
    }

    public let id: UUID
    public let headline: String
    public let detail: String
    public let metrics: [Metric]
    public let series: [[Double]]

    public init(
        id: UUID = UUID(),
        headline: String,
        detail: String,
        metrics: [Metric],
        series: [[Double]]
    ) {
        self.id = id
        self.headline = headline
        self.detail = detail
        self.metrics = metrics
        self.series = series
    }
}
