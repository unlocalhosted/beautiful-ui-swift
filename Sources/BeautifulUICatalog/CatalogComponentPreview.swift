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
            CatalogDemoContainer(
                variants: ReferenceThinkingVariant.allCases.map(\.title),
                selectedVariant: ReferenceThinkingVariant.allCases.firstIndex(of: store.thinkingVariant) ?? 0,
                onSelectVariant: { store.thinkingVariant = ReferenceThinkingVariant.allCases[$0] }
            ) {
                ReferenceThinkingDemo(variant: store.thinkingVariant)
            }
        case .streaming:
            CatalogDemoContainer {
                ReferenceStreamingDemo()
            }
        case .approval:
            CatalogDemoContainer {
                ReferenceApprovalDemo()
            }
        case .tools:
            CatalogDemoContainer {
                ReferenceToolCallsDemo()
            }
        case .tasks:
            CatalogDemoContainer(
                variants: ReferenceTaskVariant.allCases.map(\.title),
                selectedVariant: ReferenceTaskVariant.allCases.firstIndex(of: store.taskVariant) ?? 0,
                onSelectVariant: { store.taskVariant = ReferenceTaskVariant.allCases[$0] }
            ) {
                ReferenceTasksDemo(variant: store.taskVariant)
            }
        case .chat:
            CatalogDemoContainer {
                ReferenceChatDemo()
            }
        case .prompt:
            CatalogDemoContainer(
                variants: ReferencePromptVariant.allCases.map(\.title),
                selectedVariant: ReferencePromptVariant.allCases.firstIndex(of: store.promptVariant) ?? 0,
                onSelectVariant: { store.promptVariant = ReferencePromptVariant.allCases[$0] }
            ) {
                ReferencePromptDemo(variant: store.promptVariant)
            }
        case .recommendation:
            CatalogDemoContainer {
                ReferenceRecommendationDemo()
            }
        case .context:
            CatalogDemoContainer {
                ReferenceContextDemo()
            }
        case .changes:
            CatalogDemoContainer {
                ReferenceChangesDemo()
            }
        case .records:
            CatalogDemoContainer {
                ReferenceRecordsDemo()
            }
        case .filters:
            CatalogDemoContainer {
                ReferenceFilterDemo()
            }
        case .workspace:
            CatalogDemoContainer {
                WorkspaceSidebar(
                    workspaceName: "Creamery Ops",
                    workspaceDetail: "Production workspace",
                    selection: $store.workspaceDestination,
                    onCreateTask: { store.showNotice("New task intent captured.") }
                )
                .frame(minHeight: 370)
            }
        case .search:
            CatalogDemoContainer {
                ReferenceSearchDemo()
            }
        case .insights:
            CatalogDemoContainer {
                InsightCard(insights: CatalogFixtures.insights, selectedInsightID: $store.selectedInsightID) { insight in
                    store.showNotice("Follow-up on \(insight.headline)")
                }
            }
        case .code:
            CatalogDemoContainer {
                ReferenceCodeDemo()
            }
        case .fineTune:
            CatalogDemoContainer {
                ReferenceFineTuneDemo()
            }
        case .selection:
            CatalogDemoContainer {
                ReferenceSelectionDemo()
            }
        }
    }
}
