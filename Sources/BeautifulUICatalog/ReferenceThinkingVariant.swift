import Foundation

enum ReferenceThinkingVariant: String, CaseIterable, Identifiable {
    case steps = "Steps"
    case reasoning = "Reasoning"
    case search = "Search"
    case coding = "Coding"

    var id: String { rawValue }
    var title: String { rawValue }
}
