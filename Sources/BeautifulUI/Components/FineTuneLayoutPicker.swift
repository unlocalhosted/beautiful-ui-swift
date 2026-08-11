import SwiftUI

struct FineTuneLayoutPicker: View {
    @Binding var layout: FineTuneValues.Layout

    var body: some View {
        HStack(spacing: BeautifulMetrics.compact) {
            ForEach(FineTuneValues.Layout.allCases, id: \.self) { layout in
                Button {
                    self.layout = layout
                } label: {
                    Label(layout.rawValue.capitalized, systemImage: layout.symbolName)
                }
                .buttonStyle(BeautifulSecondaryButtonStyle())
                .opacity(self.layout == layout ? 1 : 0.66)
                .accessibilityAddTraits(self.layout == layout ? .isSelected : [])
            }
        }
    }
}
