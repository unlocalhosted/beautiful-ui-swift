import SwiftUI

struct ChatMessageContent: View {
    let message: ChatMessage

    var body: some View {
        VStack(alignment: .leading, spacing: BeautifulMetrics.micro) {
            Text(message.text)
                .textSelection(.enabled)
            if let metadata = message.metadata {
                Text(metadata)
                    .font(.system(size: 11.5))
                    .foregroundStyle(.secondary)
            }
        }
        .font(.system(size: 12.5))
        .padding(BeautifulMetrics.regular)
        .background(message.role == .assistant ? Color.gray.opacity(0.12) : Color.accentColor.opacity(0.16), in: .rect(cornerRadius: 8))
    }
}
