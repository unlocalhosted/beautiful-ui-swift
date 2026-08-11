import BeautifulUI
import SwiftUI

struct CatalogComponentPreview: View {
    let section: CatalogSection
    @Bindable var store: CatalogStore

    var body: some View {
        switch section {
        case .loading:
            CatalogDemoContainer(
                variants: LoadingStyle.allCases.map(\.title),
                selectedVariant: LoadingStyle.allCases.firstIndex(of: store.loadingStyle) ?? 0,
                onSelectVariant: { index in
                    store.loadingStyle = LoadingStyle.allCases[index]
                }
            ) {
                CatalogLoadingDemo(style: $store.loadingStyle)
            }
        case .thinking:
            CatalogDemoContainer(variants: ["Steps", "Reasoning", "Search", "Coding"]) {
                ThinkingTraceView(steps: CatalogFixtures.thinkingSteps)
            }
        case .streaming:
            CatalogDemoContainer(variants: ["Answer", "With sources", "With actions"]) {
                StreamingResponseView(
                    text: "Pistachio is your fastest-growing flavor. Sales are up 23% this month and margins remain stable.",
                    sources: CatalogFixtures.sources,
                    actions: [.init(title: "Save insight", symbolName: "bookmark"), .init(title: "Share", symbolName: "square.and.arrow.up")],
                    followUps: ["Which flavors sell best in winter?", "Compare gelato and soft serve margins"],
                    onAction: { action in store.showNotice("\(action.title) requested.") },
                    onFollowUp: { followUp in store.showNotice("Follow-up ready: \(followUp)") }
                )
            }
        case .approval:
            CatalogDemoContainer(variants: ["Choices", "Custom", "Confirm"]) {
                ApprovalCard(
                    request: CatalogFixtures.approvalRequest,
                    onSubmit: { _ in store.showNotice("Approval captured. Host app decides next action.") },
                    onDismiss: { store.showNotice("Approval dismissed.") }
                )
            }
        case .tools:
            CatalogDemoContainer(variants: ["Collapsed", "Expanded", "Error"]) {
                ToolCallGroup(calls: CatalogFixtures.toolCalls, initiallyExpanded: true)
            }
        case .tasks:
            CatalogDemoContainer(variants: ["Running", "Mixed", "Complete"]) {
                AgentTaskList(tasks: CatalogFixtures.agentTasks)
            }
        case .chat:
            CatalogDemoContainer(variants: ["Compact", "Threads", "Live"]) {
                ChatPanel(
                    tabs: store.chatTabs,
                    messages: store.messages,
                    selectedTabID: $store.selectedChatTabID,
                    draft: $store.chatDraft,
                    onSend: store.sendChat
                )
            }
        case .prompt:
            CatalogDemoContainer(variants: ["Default", "Attachments", "Voice"]) {
                PromptBar(
                    draft: $store.promptDraft,
                    models: ["Vanilla 1", "Sprinkles 5"],
                    selectedModel: $store.selectedModel,
                    onAddAttachments: { store.showNotice("Attachment picker belongs to host app.") },
                    onDictate: { store.showNotice("Dictation permission belongs to host app.") },
                    onSend: store.sendPrompt
                )
            }
        case .recommendation:
            CatalogDemoContainer(variants: ["Suggestion", "Options", "Accepted"]) {
                RecommendationCard(
                    recommendation: CatalogFixtures.recommendation,
                    onAccept: { store.showNotice("Recommendation accepted in local demo.") },
                    onAlternatives: { store.showNotice("Alternatives requested.") }
                )
            }
        case .context:
            CatalogDemoContainer(variants: ["Documents", "Web", "Mixed"]) {
                VStack(spacing: BeautifulMetrics.regular) {
                    ForEach(CatalogFixtures.chunks) { chunk in
                        ContextChunkCard(chunk: chunk)
                    }
                }
            }
        case .changes:
            CatalogDemoContainer(variants: ["Review", "Diff", "Applied"]) {
                ChangeTable(title: "Proposed menu cleanup", columns: ["Flavor", "Category", "Supplier"], changes: CatalogFixtures.changes)
            }
        case .records:
            CatalogDemoContainer(variants: ["Directory", "CRM", "Selected"]) {
                RecordTable(records: CatalogFixtures.records) { record in
                    store.showNotice("Selected \(record.title)")
                }
            }
        case .filters:
            CatalogDemoContainer(variants: ["All", "Active", "Done"]) {
                FilterableTaskTable(tasks: CatalogFixtures.filterTasks, selectedState: $store.selectedTaskState)
            }
        case .workspace:
            CatalogDemoContainer(variants: ["Workspace", "Project", "Inbox"]) {
                WorkspaceSidebar(
                    workspaceName: "Creamery Ops",
                    workspaceDetail: "Production workspace",
                    selection: $store.workspaceDestination,
                    onCreateTask: { store.showNotice("New task intent captured.") }
                )
                .frame(minHeight: 370)
            }
        case .search:
            CatalogDemoContainer(variants: ["Commands", "Search", "Empty"]) {
                CommandSearch(query: $store.searchQuery, suggestions: CatalogFixtures.searchSuggestions) { suggestion in
                    store.showNotice("Selected command: \(suggestion)")
                }
            }
        case .insights:
            CatalogDemoContainer(variants: ["Trends", "Forecast", "Details"]) {
                InsightCard(insights: CatalogFixtures.insights, selectedInsightID: $store.selectedInsightID) { insight in
                    store.showNotice("Follow-up on \(insight.headline)")
                }
            }
        case .code:
            CatalogDemoContainer(variants: ["Swift", "Diff", "Terminal"]) {
                CodeBlock(snippet: CatalogFixtures.snippet) {
                    store.showNotice("Copy requested. Host app owns clipboard policy.")
                }
            }
        case .fineTune:
            CatalogDemoContainer(variants: ["Layout", "Appearance", "Data"]) {
                FineTuneCard(title: "Flavor card", values: $store.fineTuneValues)
            }
        case .selection:
            CatalogDemoContainer(variants: ["Edit", "Improve", "Review"]) {
                SelectionActions(
                    selectedText: "Pistachio holds the top slot all weekend. Churn it first thing Saturday so the batch can firm before the afternoon rush.",
                    instruction: $store.editInstruction,
                    onAction: { action in store.showNotice("\(action.title) selected.") },
                    onSend: { store.showNotice("Edit instruction sent to host route.") }
                )
            }
        }
    }
}
