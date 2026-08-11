import BeautifulUI
import Foundation

enum CatalogFixtures {
    static let thinkingSteps: [ThinkingStep] = [
        .init(kind: .planning, title: "Plan response", detail: "Comparing forecast and inventory position.", duration: .seconds(1)),
        .init(kind: .search, title: "Find relevant records", detail: "Matched POS exports and supplier history.", duration: .seconds(2)),
        .init(kind: .reasoning, title: "Evaluate stockout risk", detail: "Weekend demand changes reorder recommendation.", duration: .seconds(1))
    ]

    static let sources: [ReferenceSource] = [
        .init(title: "Sales index", subtitle: "sales.example.com"),
        .init(title: "Market basket", subtitle: "marketbasket.example.com")
    ]

    static let approvalRequest = ApprovalRequest(
        prompt: "How many flavors should we launch?",
        options: [
            .init(title: "Three", detail: "Core line"),
            .init(title: "Five", detail: "Full case"),
            .init(title: "One", detail: "Hero flavor")
        ]
    )

    static let toolCalls: [ToolCall] = [
        .init(kind: .thinking, title: "Plan churn schedule", detail: "In progress"),
        .init(kind: .write, title: "Write 204 lines", detail: "ChurnSchedule.swift"),
        .init(kind: .command, title: "Build and verify", detail: "swift test"),
        .init(kind: .read, title: "Read image", detail: "flavor-chart.png")
    ]

    static let agentTasks: [AgentTask] = [
        .init(title: "Verify vendor records", detail: "Matched tax and contact IDs", state: .completed, quantityLabel: "12 suppliers"),
        .init(title: "Build reorder task list", detail: "Scoring stockout risk", state: .running, progress: 0.68, quantityLabel: "7 SKUs"),
        .init(title: "Draft supplier emails", detail: "Pistachio reorder note", state: .needsReview, quantityLabel: "2 messages")
    ]

    static let chatTabs: [ChatTab] = [
        .init(title: "Flavors"),
        .init(title: "Suppliers")
    ]

    static let messages: [ChatMessage] = [
        .init(role: .user, text: "Compare mint chip to last summer"),
        .init(role: .assistant, text: "Mint chip is up 12% with stronger weekend peaks.", metadata: "Trend detection · 2s")
    ]

    static let recommendation = Recommendation(
        title: "Want me to place this restock order?",
        summary: "Reorder waffle cones with a lead time of 7 days.",
        confidence: .high,
        alternatives: ["Switch to vanilla Madagascar", "Full restock across every SKU"]
    )

    static let chunks: [ContextChunk] = [
        .init(title: "Vendor onboarding rule", excerpt: "Cold-chain certification must be verified before a new dairy can be added to the reorder workflow.", sourceName: "Dairy Onboarding SOP.pdf", sourceKind: .document, characterCount: 290),
        .init(title: "Seasonal demand row", excerpt: "Q4 velocity: pistachio +18%, vanilla +6%, rocky road −11%.", sourceName: "Sales Velocity Export.csv", sourceKind: .spreadsheet, characterCount: 1_250)
    ]

    static let changes: [RecordChange] = [
        .init(values: ["Rocky Road", "Classic", "aurora-scoops"], disposition: .removed),
        .init(values: ["Bubblegum", "Retro", "kumo-creamery"], disposition: .removed),
        .init(values: ["Mint Chip", "Classic", "maple-orbit"], disposition: .unchanged),
        .init(values: ["Pistachio", "Seasonal", "maple-orbit"], disposition: .added)
    ]

    static let records: [Record] = [
        .init(title: "Aurora Scoops — Reykjavík", monogram: "A", fields: [.init(title: "Categories", value: "Gelato", tags: ["Gelato", "Seasonal"]), .init(title: "Connection", value: "Very strong")]),
        .init(title: "Kumo Creamery — Tokyo", monogram: "K", fields: [.init(title: "Categories", value: "B2C", tags: ["B2C", "Café", "Vegan"]), .init(title: "Connection", value: "Very strong")]),
        .init(title: "Maple Orbit — Montréal", monogram: "M", fields: [.init(title: "Categories", value: "B2B", tags: ["B2B", "Wholesale"]), .init(title: "Connection", value: "Weak")])
    ]

    static let filterTasks: [FilterTask] = [
        .init(title: "Restock mango sorbet", date: .now, advisor: "Mango Moon Gelato", state: .todo),
        .init(title: "Churn black sesame", date: .now.addingTimeInterval(-86_400 * 10), advisor: "Kumo Creamery", state: .inProgress),
        .init(title: "Print summer menu", date: .now.addingTimeInterval(86_400 * 20), advisor: "Coral Coast Sorbet", state: .todo),
        .init(title: "Taste-test batch 42", date: .now, advisor: "Maple Orbit", state: .inProgress),
        .init(title: "Order waffle cones", date: .now, advisor: "Aurora Scoops", state: .completed)
    ]

    static let searchSuggestions = [
        "Forecast summer demand",
        "Find waffle cone suppliers",
        "Compare seasonal flavors",
        "Draft flavor launch plan",
        "Check cold-chain status"
    ]

    static let insights: [Insight] = [
        .init(
            headline: "Rocky Road is your weakest performer.",
            detail: "It is down 6% versus last quarter, while Pistachio continues to rise.",
            metrics: [.init(name: "Mint Chip", delta: -0.0441, amount: -2_377.66), .init(name: "Pistachio", delta: 0.0115, amount: 617.22)],
            series: [[6, 7, 6, 8, 8, 9, 10], [5, 4, 5, 3, 4, 3, 2]]
        )
    ]

    static let snippet = CodeSnippet(
        filename: "churn.swift",
        language: "Swift",
        source: "func churnBatch() async throws {\n    let flavor = try await inventory.favorite(\\\"pistachio\\\")\n    return try await freezer.store(flavor)\n}"
    )
}
