import Foundation

public enum CatalogSection: String, CaseIterable, Identifiable, Sendable {
    case loading
    case thinking
    case streaming
    case approval
    case tools
    case tasks
    case chat
    case prompt
    case recommendation
    case context
    case changes
    case records
    case filters
    case workspace
    case search
    case insights
    case code
    case fineTune
    case selection

    public var id: String { rawValue }

    public var number: Int {
        Self.allCases.firstIndex(of: self).map { $0 + 1 } ?? 0
    }

    public var title: String {
        switch self {
        case .loading: "Loading State"
        case .thinking: "Thinking"
        case .streaming: "Streaming Text"
        case .approval: "Approval Card"
        case .tools: "Tool Chips"
        case .tasks: "Task Rows"
        case .chat: "Chat"
        case .prompt: "Prompt Bar"
        case .recommendation: "Recommendation Card"
        case .context: "Context Cards"
        case .changes: "Diff Table"
        case .records: "Records Table"
        case .filters: "Filter Table"
        case .workspace: "Sidebar Nav"
        case .search: "Search"
        case .insights: "Insight Cards"
        case .code: "Code Block"
        case .fineTune: "Fine-tune Card"
        case .selection: "Selection Actions"
        }
    }

    public var subtitle: String {
        switch self {
        case .loading: "Pixel-grid loader with shimmer and elapsed time."
        case .thinking: "Expandable traces — steps, reasoning, search, coding."
        case .streaming: "Streamed answer with inline sources, actions, and follow-ups."
        case .approval: "Human-in-the-loop questions the agent asks before acting."
        case .tools: "Code edits and tool calls as compact chips."
        case .tasks: "Live agent task status — running, failed, completed."
        case .chat: "Tabbed chat panel with reasoning replies and a composer."
        case .prompt: "Composer with @ sources, / commands, model picker, and dictation."
        case .recommendation: "Agent suggestion with a confidence meter and actions."
        case .context: "Retrieved knowledge chunks with their sources."
        case .changes: "AI-proposed edits sweeping through tabular data."
        case .records: "CRM-style grid with tags, sorting, and relationship status."
        case .filters: "Status chips that reorganize live data."
        case .workspace: "Workspace navigation with quick search."
        case .search: "Command search with live filtering and an empty state."
        case .insights: "Paged agent insights with scrub-ready live charts."
        case .code: "Agent-written code streaming in line by line."
        case .fineTune: "The agent adjusts design properties in an inspector."
        case .selection: "Highlight a passage and hand it to the agent to rewrite."
        }
    }
}
