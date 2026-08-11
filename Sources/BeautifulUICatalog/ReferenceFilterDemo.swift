import BeautifulUI
import SwiftUI

/// Native port of the reference `Filter` primitive.
struct ReferenceFilterDemo: View {
    enum Filter: String, CaseIterable, Identifiable {
        case all = "All", todo = "To do", progress = "In Progress", done = "Completed"
        var id: String { rawValue }
        var count: Int { switch self { case .all: 5; case .todo: 2; case .progress: 2; case .done: 1 } }
        var tint: Color? { switch self { case .all: nil; case .todo: .orange; case .progress: .cyan; case .done: .green } }
    }

    @Environment(\.beautifulTheme) private var theme
    @State private var filter: Filter = .all

    private let tasks = [
        ReferenceFilterTask("Restock mango sorbet", "Dec 03", .todo, "Mango Moon Gelato"),
        ReferenceFilterTask("Churn black sesame", "Sep 22", .progress, "Kumo Creamery"),
        ReferenceFilterTask("Print summer menu", "Jan 02", .todo, "Coral Coast Sorbet"),
        ReferenceFilterTask("Taste-test batch 42", "Nov 08", .progress, "Maple Orbit"),
        ReferenceFilterTask("Order waffle cones", "Apr 14", .done, "Aurora Scoops")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 4) {
                    ForEach(Filter.allCases, id: \.id) { option in
                        let isSelected = filter == option
                        Button {
                            filter = option
                        } label: {
                            HStack(spacing: 6) {
                                if let tint = option.tint { Circle().fill(tint).frame(width: 6, height: 6) }
                                Text(option.rawValue)
                                Text("\(option.count)")
                                    .font(.system(size: 10.5))
                                    .foregroundStyle(isSelected ? Color.secondary : Color.secondary.opacity(0.65))
                                    .padding(.horizontal, 4)
                                    .background(isSelected ? theme.elevatedSurface : .clear, in: .rect(cornerRadius: 4))
                            }
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(isSelected ? Color.primary : Color.secondary)
                            .padding(.horizontal, 10)
                            .frame(height: 26)
                            .background(isSelected ? theme.surface : .clear, in: .capsule)
                            .overlay { if isSelected { Capsule().stroke(theme.border, lineWidth: 1) } }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 1)
                .padding(.vertical, 4)
            }

            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    header("Task name", width: 0.32)
                    header("Date", width: 0.16)
                    header("Status", width: 0.24)
                    header("Advisor", width: 0.28)
                }
                .padding(.horizontal, 12)
                .frame(height: 36)
                .overlay(alignment: .bottom) { Rectangle().fill(theme.border).frame(height: 1) }

                ForEach(tasks.filter { filter == .all || $0.status == filter }) { task in
                    HStack(spacing: 0) {
                        Text(task.name).font(.system(size: 12, weight: .medium)).lineLimit(1).frame(maxWidth: .infinity, alignment: .leading)
                        Text(task.date).font(.system(size: 12)).foregroundStyle(.secondary).monospacedDigit().frame(maxWidth: .infinity, alignment: .leading)
                        Text(task.status.rawValue)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(task.status.tint ?? .secondary)
                            .padding(.horizontal, 6)
                            .frame(height: 20)
                            .background((task.status.tint ?? .secondary).opacity(0.14), in: .rect(cornerRadius: 5))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(task.owner).font(.system(size: 12)).foregroundStyle(.secondary).lineLimit(1).frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 12)
                    .frame(height: 38)
                    .overlay(alignment: .bottom) { Rectangle().fill(theme.border).frame(height: 1) }
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
            .frame(minWidth: 420)
            .background(theme.surface, in: .rect(cornerRadius: 12))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(theme.border, lineWidth: 1))
        }
        .frame(maxWidth: 420, alignment: .leading)
        .animation(.timingCurve(0.23, 1, 0.32, 1, duration: 0.3), value: filter)
    }

    private func header(_ title: String, width: CGFloat) -> some View {
        Text(title)
            .font(.system(size: 11.5, weight: .medium))
            .foregroundStyle(.tertiary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct ReferenceFilterTask: Identifiable {
    let id = UUID()
    let name: String
    let date: String
    let status: ReferenceFilterDemo.Filter
    let owner: String
    init(_ name: String, _ date: String, _ status: ReferenceFilterDemo.Filter, _ owner: String) {
        self.name = name; self.date = date; self.status = status; self.owner = owner
    }
}
