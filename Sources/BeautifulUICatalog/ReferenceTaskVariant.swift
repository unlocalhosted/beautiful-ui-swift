import Foundation

enum ReferenceTaskVariant: String, CaseIterable, Identifiable {
    case capsules = "Capsules"
    case list = "List"

    var id: String { rawValue }
    var title: String { rawValue }
}
