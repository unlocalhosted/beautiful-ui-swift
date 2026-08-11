import SwiftUI

struct SelectionActionToolbar: View {
    let onAction: (SelectionAction) -> Void

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: BeautifulMetrics.compact) {
                ForEach(SelectionAction.allCases) { action in
                    Button(action.title, systemImage: action.symbolName) {
                        onAction(action)
                    }
                    .buttonStyle(BeautifulSecondaryButtonStyle())
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}
