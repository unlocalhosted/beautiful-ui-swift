import SwiftUI

struct WorkspaceDestinationGroup: View {
    let title: String
    let destinations: [WorkspaceDestination]
    @Binding var selection: WorkspaceDestination?

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.system(size: 11.5))
                .foregroundStyle(.secondary)
                .padding(.top, 4)
            ForEach(destinations) { destination in
                WorkspaceDestinationButton(
                    destination: destination,
                    isSelected: selection == destination
                ) {
                    selection = destination
                }
            }
        }
    }
}
