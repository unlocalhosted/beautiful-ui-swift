import Foundation

public struct ReferenceSource: Identifiable, Equatable, Sendable {
    public let id: UUID
    public let title: String
    public let subtitle: String
    public let url: URL?

    public init(id: UUID = UUID(), title: String, subtitle: String, url: URL? = nil) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.url = url
    }
}
