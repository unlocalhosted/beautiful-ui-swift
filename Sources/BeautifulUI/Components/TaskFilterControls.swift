import SwiftUI

struct TaskFilterControls: View {
    let tasks: [FilterTask]
    @Binding var selectedState: FilterTask.State?

    var body: some View {
        let counts = TaskFilter.counts(from: tasks)
        ScrollView(.horizontal) {
            HStack(spacing: BeautifulMetrics.compact) {
                TaskFilterButton(title: "All", count: tasks.count, isSelected: selectedState == nil) {
                    selectedState = nil
                }
                ForEach(FilterTask.State.allCases, id: \.self) { state in
                    TaskFilterButton(
                        title: state.title,
                        count: counts[state, default: 0],
                        isSelected: selectedState == state
                    ) {
                        selectedState = state
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}
