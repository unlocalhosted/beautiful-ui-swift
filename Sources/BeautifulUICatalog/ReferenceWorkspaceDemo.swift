import BeautifulUI
import SwiftUI

/// Native port of the reference `Sidebar` primitive.
struct ReferenceWorkspaceDemo: View {
    @Environment(\.beautifulTheme) private var theme
    @State private var selected = "tasks"
    @State private var taskCount = 4
    @State private var query = ""

    private let items = [
        ReferenceWorkspaceItem(key: "activity", title: "Home", section: "Workspace", icon: "waveform.path.ecg"),
        ReferenceWorkspaceItem(key: "tasks", title: "Agent tasks", section: "Workspace", icon: "checklist", hasCount: true),
        ReferenceWorkspaceItem(key: "dashboard", title: "Inbox", section: "Workspace", icon: "square.grid.2x2"),
        ReferenceWorkspaceItem(key: "spaces", title: "Suppliers", section: "Objects", icon: "square.stack.3d.up", hasPlus: true),
        ReferenceWorkspaceItem(key: "analytics", title: "Inventory", section: "Objects", icon: "chart.bar")
    ]

    private var filteredItems: [ReferenceWorkspaceItem] {
        query.isEmpty ? items : items.filter { $0.title.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {}) {
                HStack(spacing: 10) {
                    Text("C")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(theme.surface)
                        .frame(width: 32, height: 32)
                        .background(Color.primary, in: .rect(cornerRadius: 8))
                    VStack(alignment: .leading, spacing: 1) {
                        Text("Creamery Ops").font(.system(size: 13, weight: .medium))
                        Text("Production Workspace").font(.system(size: 11)).foregroundStyle(.tertiary)
                    }
                    Spacer()
                    Image(systemName: "chevron.up.chevron.down").font(.system(size: 11, weight: .bold)).foregroundStyle(.tertiary)
                }
                .padding(6)
            }
            .buttonStyle(ReferenceWorkspaceRowStyle())
            .padding(.bottom, 8)

            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass").font(.system(size: 12, weight: .medium)).foregroundStyle(.tertiary)
                TextField("Quick search", text: $query)
                    .textFieldStyle(.plain)
                    .font(.system(size: 12.5))
                Text("/")
                    .font(.system(size: 10, design: .monospaced))
                    .foregroundStyle(.tertiary)
                    .frame(width: 18, height: 18)
                    .background(theme.surface, in: .rect(cornerRadius: 5))
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(theme.border, lineWidth: 1))
            }
            .padding(.horizontal, 10)
            .frame(height: 32)
            .background(theme.elevatedSurface, in: .rect(cornerRadius: 7))
            .overlay(RoundedRectangle(cornerRadius: 7).stroke(theme.border, lineWidth: 1))
            .padding(.bottom, 4)

            Button {
                taskCount += 1
                selected = "tasks"
            } label: {
                HStack(spacing: 8) {
                    Text("New task").font(.system(size: 13, weight: .medium))
                    Spacer()
                    Image(systemName: "plus")
                        .font(.system(size: 9, weight: .black))
                        .foregroundStyle(.white)
                        .frame(width: 16, height: 16)
                        .background(theme.accent, in: .circle)
                }
                .padding(.horizontal, 8)
                .frame(height: 30)
            }
            .buttonStyle(ReferenceWorkspaceRowStyle())
            .foregroundStyle(theme.accent)
            .padding(.bottom, 6)

            ForEach(["Workspace", "Objects"], id: \.self) { section in
                Text(section.uppercased())
                    .font(.system(size: 10.5, weight: .medium))
                    .tracking(0.8)
                    .foregroundStyle(.tertiary)
                    .padding(.horizontal, 8)
                    .padding(.top, 4)
                    .padding(.bottom, 3)
                ForEach(filteredItems.filter { $0.section == section }) { item in
                    workspaceItem(item)
                }
            }
        }
        .padding(8)
        .frame(width: 240, alignment: .leading)
        .background(theme.surface, in: .rect(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(theme.border, lineWidth: 1))
        .shadow(color: .black.opacity(0.16), radius: 12, y: 4)
    }

    private func workspaceItem(_ item: ReferenceWorkspaceItem) -> some View {
        let isSelected = selected == item.key
        return Button {
            selected = item.key
        } label: {
            HStack(spacing: 8) {
                Image(systemName: item.icon)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(isSelected ? Color.primary : Color.secondary)
                    .frame(width: 16)
                Text(item.title)
                    .font(.system(size: 13, weight: isSelected ? .medium : .regular))
                Spacer()
                if item.hasCount {
                    Text("\(taskCount)")
                        .font(.system(size: 10.5, weight: .semibold))
                        .foregroundStyle(isSelected ? Color.secondary : theme.accent)
                        .padding(.horizontal, 5)
                        .frame(height: 18)
                        .background(isSelected ? theme.surface : theme.accent.opacity(0.14), in: .capsule)
                }
                if item.hasPlus {
                    Image(systemName: "plus")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.tertiary)
                        .frame(width: 18, height: 18)
                }
            }
            .padding(.horizontal, 8)
            .frame(height: 30)
        }
        .buttonStyle(ReferenceWorkspaceRowStyle(isSelected: isSelected))
    }
}

private struct ReferenceWorkspaceItem: Identifiable {
    let key: String
    let title: String
    let section: String
    let icon: String
    var hasCount = false
    var hasPlus = false
    var id: String { key }
}

private struct ReferenceWorkspaceRowStyle: ButtonStyle {
    var isSelected = false
    @Environment(\.beautifulTheme) private var theme
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.background(isSelected || configuration.isPressed ? theme.elevatedSurface : .clear, in: .rect(cornerRadius: 7))
    }
}
