import SwiftUI

struct TaskFilterControls: View {
    let tasks: [FilterTask]
    @Binding var selectedState: FilterTask.State?

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: BeautifulMetrics.compact) {
                TaskFilterButton(title: "All", count: tasks.count, isSelected: selectedState == nil) {
                    selectedState = nil
                }
                ForEach(FilterTask.State.allCases, id: \.self) { state in
                    TaskFilterButton(
                        title: state.title,
                        count: tasks.count(where: { $0.state == state }),
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
