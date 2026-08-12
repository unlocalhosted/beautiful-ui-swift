import Foundation

public enum TaskFilter {
    public static func tasks(
        matching state: FilterTask.State?,
        from tasks: [FilterTask]
    ) -> [FilterTask] {
        guard let state else { return tasks }
        return tasks.filter { $0.state == state }
    }

    public static func counts(from tasks: [FilterTask]) -> [FilterTask.State: Int] {
        tasks.reduce(into: [:]) { counts, task in
            counts[task.state, default: 0] += 1
        }
    }
}
