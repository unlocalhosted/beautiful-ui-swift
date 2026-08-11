import SwiftUI

struct ChatTabPicker: View {
    let tabs: [ChatTab]
    @Binding var selectedTabID: ChatTab.ID?

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: BeautifulMetrics.compact) {
                ForEach(tabs) { tab in
                    Button(tab.title, action: { selectedTabID = tab.id })
                        .buttonStyle(BeautifulSecondaryButtonStyle())
                        .tint(selectedTabID == tab.id ? .accentColor : .secondary)
                        .accessibilityAddTraits(selectedTabID == tab.id ? .isSelected : [])
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}
