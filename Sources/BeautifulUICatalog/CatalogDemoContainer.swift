import BeautifulUI
import SwiftUI

struct CatalogDemoContainer<Content: View>: View {
    private let content: Content
    private let variants: [String]
    private let onSelectVariant: ((Int) -> Void)?

    @Environment(\.beautifulTheme) private var theme
    @State private var selectedVariant: Int
    @State private var isHovering = false

    init(
        variants: [String] = [],
        selectedVariant: Int = 0,
        onSelectVariant: ((Int) -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.variants = variants
        self.onSelectVariant = onSelectVariant
        _selectedVariant = State(initialValue: selectedVariant)
        self.content = content()
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            content
                .frame(maxWidth: 480, alignment: .leading)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding(34)

            if isHovering {
                ReferenceDemoActions()
                    .padding(12)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 272)
        .background(theme.canvas, in: .rect(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(theme.border, lineWidth: 1)
        }
        .overlay(alignment: .bottom) {
            if !variants.isEmpty {
                ReferenceVariantControl(
                    labels: variants,
                    selectedIndex: $selectedVariant,
                    onSelect: onSelectVariant
                )
                .padding(.bottom, 10)
            }
        }
        .onHover { isHovering = $0 }
    }
}
