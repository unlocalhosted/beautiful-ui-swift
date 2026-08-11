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
}
