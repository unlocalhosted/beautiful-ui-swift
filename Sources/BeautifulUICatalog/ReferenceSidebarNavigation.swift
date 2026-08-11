import SwiftUI

struct ReferenceSidebarNavigation: View {
    let selectedSection: CatalogSection?
    let onSelect: (CatalogSection) -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 2) {
                Text("Components")
                    .font(.system(size: 11.5))
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 4)
                ForEach(CatalogSection.allCases) { section in
                    ReferenceSidebarSectionButton(
                        section: section,
                        isSelected: section == selectedSection
                    ) {
                        onSelect(section)
                    }
                }
            }
            .padding(.top, 22)
        }
        .scrollIndicators(.hidden)
    }
}
