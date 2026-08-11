import BeautifulUI
import Observation
import SwiftUI

@MainActor @Observable public final class CatalogStore {
    public var selectedSection: CatalogSection? = .loading
    public var loadingStyle: LoadingStyle = .grid
    public var chatTabs = CatalogFixtures.chatTabs
    public var selectedChatTabID: ChatTab.ID?
    public var chatDraft = ""
    public var messages = CatalogFixtures.messages
    public var promptDraft = ""
    public var selectedModel = "Vanilla 1"
    public var selectedTaskState: FilterTask.State?
    public var workspaceDestination: WorkspaceDestination? = .home
    public var searchQuery = ""
    public var selectedInsightID: Insight.ID?
    public var fineTuneValues = FineTuneValues()
    public var editInstruction = ""
    public var notice: String?

    public init() {
        selectedChatTabID = chatTabs.first?.id
        selectedInsightID = CatalogFixtures.insights.first?.id
    }

    public func sendChat() {
        let message = chatDraft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !message.isEmpty else { return }
        messages.append(.init(role: .user, text: message))
        chatDraft = ""
        notice = "Message added to local demo conversation."
    }

    public func sendPrompt() {
        let message = promptDraft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !message.isEmpty else { return }
        promptDraft = ""
        notice = "Prompt ready for host application routing."
    }

    public func showNotice(_ message: String) {
        notice = message
    }
}
