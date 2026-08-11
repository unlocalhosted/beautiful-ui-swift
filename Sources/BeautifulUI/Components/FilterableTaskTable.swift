import SwiftUI

/// Native filter controls paired with a task list that stays usable at every size class.
public struct FilterableTaskTable: View {
    public let tasks: [FilterTask]
    @Binding public var selectedState: FilterTask.State?

    public init(tasks: [FilterTask], selectedState: Binding<FilterTask.State?>) {
        self.tasks = tasks
        _selectedState = selectedState
    }

    public var body: some View {
        BeautifulSurface(padding: BeautifulMetrics.compact) {
            VStack(alignment: .leading, spacing: BeautifulMetrics.regular) {
                TaskFilterControls(tasks: tasks, selectedState: $selectedState)
                LazyVStack(spacing: BeautifulMetrics.micro) {
                    ForEach(TaskFilter.tasks(matching: selectedState, from: tasks)) { task in
                        FilterTaskRow(task: task)
                    }
                }
            }
        }
    }
}

#Preview {
    FilterableTaskTable(tasks: [.init(title: "Restock mango sorbet", date: .now, advisor: "Mango Moon", state: .todo), .init(title: "Taste-test batch 42", date: .now, advisor: "Maple Orbit", state: .inProgress)], selectedState: .constant(nil))
        .padding()
}
