import SwiftUI

struct ResponseActionButtons: View {
    let actions: [ResponseAction]
    let onAction: (ResponseAction) -> Void

    var body: some View {
        ForEach(actions) { action in
            Button(action.title, systemImage: action.symbolName) {
                onAction(action)
            }
            .buttonStyle(BeautifulSecondaryButtonStyle())
        }
    }
}
