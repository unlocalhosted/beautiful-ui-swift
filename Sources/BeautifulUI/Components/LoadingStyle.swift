import Foundation

public enum LoadingStyle: String, CaseIterable, Sendable {
    case grid
    case dots
    case orbit

    public var title: String {
        switch self {
        case .grid: "Drive"
        case .dots: "Dots"
        case .orbit: "Orbit"
        }
    }
}
