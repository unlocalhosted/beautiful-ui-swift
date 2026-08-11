import SwiftUI

struct ResponseActionRow: View {
    let actions: [ResponseAction]
    let onAction: (ResponseAction) -> Void

    var body: some View {
        ViewThatFits(in: .horizontal) {
            HStack(spacing: BeautifulMetrics.compact) {
                ResponseActionButtons(actions: actions, onAction: onAction)
            }
            VStack(alignment: .leading, spacing: BeautifulMetrics.compact) {
                ResponseActionButtons(actions: actions, onAction: onAction)
            }
        }
    }
}
