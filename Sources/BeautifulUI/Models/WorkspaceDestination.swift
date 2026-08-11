import Foundation

public enum WorkspaceDestination: String, CaseIterable, Identifiable, Sendable {
    case home
    case tasks
    case inbox
    case suppliers
    case inventory

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .home: "Home"
        case .tasks: "Agent tasks"
        case .inbox: "Inbox"
        case .suppliers: "Suppliers"
        case .inventory: "Inventory"
        }
    }

    public var symbolName: String {
        switch self {
        case .home: "house"
        case .tasks: "checklist"
        case .inbox: "tray"
        case .suppliers: "building.2"
        case .inventory: "shippingbox"
        }
    }
}
