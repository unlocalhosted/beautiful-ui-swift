import BeautifulUI
import Testing

struct AgentTaskStateTests {
    @Test(arguments: AgentTaskState.allCases)
    func everyStateHasAccessibleTitleAndSymbol(_ state: AgentTaskState) {
        #expect(!state.title.isEmpty)
        #expect(!state.symbolName.isEmpty)
    }
}
