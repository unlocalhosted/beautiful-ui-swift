import BeautifulUI
import Foundation
import Testing

struct TaskFilterTests {
    @Test func returnsAllTasksWhenNoStateIsSelected() {
        let tasks = [
            FilterTask(title: "A", date: .now, advisor: "One", state: .todo),
            FilterTask(title: "B", date: .now, advisor: "Two", state: .completed)
        ]

        #expect(TaskFilter.tasks(matching: nil, from: tasks) == tasks)
    }

    @Test func returnsOnlyMatchingTaskState() {
        let todo = FilterTask(title: "A", date: .now, advisor: "One", state: .todo)
        let done = FilterTask(title: "B", date: .now, advisor: "Two", state: .completed)

        #expect(TaskFilter.tasks(matching: .todo, from: [todo, done]) == [todo])
    }

    @Test func countsEveryTaskStateInOnePass() {
        let tasks = [
            FilterTask(title: "Todo", date: .now, advisor: "One", state: .todo),
            FilterTask(title: "Active", date: .now, advisor: "Two", state: .inProgress),
            FilterTask(title: "Done", date: .now, advisor: "Three", state: .completed)
        ]
        let counts = TaskFilter.counts(from: tasks)

        #expect(counts[FilterTask.State.todo] == 1)
        #expect(counts[FilterTask.State.inProgress] == 1)
        #expect(counts[FilterTask.State.completed] == 1)
    }
}
