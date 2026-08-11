import SwiftUI

/// Workspace navigation meant for `NavigationSplitView` sidebars on macOS and iPad.
public struct WorkspaceSidebar: View {
    public let workspaceName: String
    public let workspaceDetail: String
    @Binding public var selection: WorkspaceDestination?
    public let onCreateTask: () -> Void

    public init(
        workspaceName: String,
        workspaceDetail: String,
        selection: Binding<WorkspaceDestination?>,
        onCreateTask: @escaping () -> Void
    ) {
        self.workspaceName = workspaceName
        self.workspaceDetail = workspaceDetail
        _selection = selection
        self.onCreateTask = onCreateTask
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: BeautifulMetrics.regular) {
            WorkspaceIdentity(name: workspaceName, detail: workspaceDetail)
            Button("New task", systemImage: "plus", action: onCreateTask)
                .buttonStyle(BeautifulSecondaryButtonStyle())
            WorkspaceDestinationGroup(
                title: "Workspace",
                destinations: [.home, .tasks, .inbox],
                selection: $selection
            )
            WorkspaceDestinationGroup(
                title: "Objects",
                destinations: [.suppliers, .inventory],
                selection: $selection
            )
        }
        .padding(BeautifulMetrics.roomy)
        .background(.quaternary.opacity(0.24), in: .rect(cornerRadius: BeautifulMetrics.cornerRadius))
    }
}

#Preview {
    WorkspaceSidebar(workspaceName: "Creamery Ops", workspaceDetail: "Production workspace", selection: .constant(.home), onCreateTask: {})
}
