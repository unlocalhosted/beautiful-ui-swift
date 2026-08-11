import SwiftUI

struct ReferenceMobileSectionScroller: View {
    @Binding var selectedSection: CatalogSection?
    let onSelect: (CatalogSection) -> Void

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 5) {
                ForEach(CatalogSection.allCases) { section in
                    ReferenceMobileSectionChip(
                        section: section,
                        isSelected: selectedSection == section
                    ) {
                        selectedSection = section
                        onSelect(section)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}
