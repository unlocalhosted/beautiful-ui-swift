import SwiftUI

/// A compact conversation view whose draft and selected tab remain owned by the host application.
public struct ChatPanel: View {
    public let tabs: [ChatTab]
    public let messages: [ChatMessage]
    @Binding public var selectedTabID: ChatTab.ID?
    @Binding public var draft: String
    public let onSend: () -> Void

    public init(
        tabs: [ChatTab],
        messages: [ChatMessage],
        selectedTabID: Binding<ChatTab.ID?>,
        draft: Binding<String>,
        onSend: @escaping () -> Void
    ) {
        self.tabs = tabs
        self.messages = messages
        _selectedTabID = selectedTabID
        _draft = draft
        self.onSend = onSend
    }

    public var body: some View {
        BeautifulSurface(padding: BeautifulMetrics.compact) {
            VStack(alignment: .leading, spacing: BeautifulMetrics.regular) {
                ChatTabPicker(tabs: tabs, selectedTabID: $selectedTabID)
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: BeautifulMetrics.regular) {
                        ForEach(messages) { message in
                            ChatMessageBubble(message: message)
                        }
                    }
                }
                .frame(minHeight: 180, idealHeight: 280)
                PromptBar(draft: $draft, onSend: onSend)
            }
        }
    }
}

#Preview {
    ChatPanel(
        tabs: [.init(title: "Flavors"), .init(title: "Suppliers")],
        messages: [.init(role: .user, text: "Compare mint chip to last summer"), .init(role: .assistant, text: "Mint chip is up 12% with stronger weekend peaks.")],
        selectedTabID: .constant(nil),
        draft: .constant(""),
        onSend: {}
    )
    .padding()
}
