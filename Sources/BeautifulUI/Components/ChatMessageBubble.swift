import SwiftUI

struct ChatMessageBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.role == .assistant {
                ChatMessageContent(message: message)
                Spacer(minLength: BeautifulMetrics.section)
            } else {
                Spacer(minLength: BeautifulMetrics.section)
                ChatMessageContent(message: message)
            }
        }
        .accessibilityElement(children: .combine)
    }
}
