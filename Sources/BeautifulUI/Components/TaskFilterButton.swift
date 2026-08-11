import SwiftUI

struct TaskFilterButton: View {
    let title: String
    let count: Int
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("\(title) \(count)")
        }
        .buttonStyle(BeautifulSecondaryButtonStyle())
        .tint(isSelected ? .accentColor : .secondary)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
