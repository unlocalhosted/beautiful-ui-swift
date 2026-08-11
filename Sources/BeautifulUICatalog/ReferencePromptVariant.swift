import Foundation

enum ReferencePromptVariant: String, CaseIterable, Identifiable {
    case rounded = "Rounded"
    case pill = "Pill"
    var id: String { rawValue }
    var title: String { rawValue }
}
