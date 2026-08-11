import SwiftUI

struct ReferenceMobileHeader: View {
    @Binding var selectedSection: CatalogSection?
    @Binding var usesDarkAppearance: Bool
    let onSelect: (CatalogSection) -> Void

    @Environment(\.beautifulTheme) private var theme

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                HStack(spacing: 8) {
                    ReferenceLogoMark()
                        .frame(width: 28, height: 28)
                        .font(.system(size: 16, weight: .medium))
                    Text("Beautiful UI")
                        .font(.system(size: 13, weight: .semibold))
                }
                Spacer()
                ReferenceMobileAppearanceButton(usesDarkAppearance: $usesDarkAppearance)
                Menu {
                    ForEach(CatalogSection.allCases) { section in
                        Button(section.title) {
                            selectedSection = section
                            onSelect(section)
                        }
                    }
                } label: {
                    Label("Components", systemImage: "list.bullet")
                        .labelStyle(.iconOnly)
                        .font(.system(size: 14, weight: .medium))
                        .frame(width: 40, height: 40)
                        .background(theme.elevatedSurface, in: .circle)
                }
                .accessibilityLabel("Components")
            }
            ReferenceMobileSectionScroller(
                selectedSection: $selectedSection,
                onSelect: onSelect
            )
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(theme.sidebar)
        .overlay(alignment: .bottom) {
            Rectangle()
                .stroke(theme.border, style: StrokeStyle(lineWidth: 1, dash: [3, 3]))
                .frame(height: 1)
        }
    }
}
