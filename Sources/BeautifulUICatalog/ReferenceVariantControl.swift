import SwiftUI

struct ReferenceVariantControl: View {
    let labels: [String]
    @Binding var selectedIndex: Int
    let onSelect: ((Int) -> Void)?

    @Environment(\.beautifulTheme) private var theme

    var body: some View {
        HStack(spacing: 1) {
            ForEach(Array(labels.enumerated()), id: \.offset) { index, label in
                Button(label) {
                    selectedIndex = index
                    onSelect?(index)
                }
                .font(.system(size: 11.5, weight: .medium))
                .foregroundStyle(index == selectedIndex ? .primary : .secondary)
                .padding(.horizontal, 8)
                .frame(height: 24)
                .background {
                    if index == selectedIndex {
                        RoundedRectangle(cornerRadius: 99)
                            .fill(theme.surface)
                            .shadow(color: .black.opacity(0.22), radius: 1, y: 1)
                    }
                }
                .buttonStyle(ReferencePlainButtonStyle())
            }
        }
        .padding(2)
        .background(theme.elevatedSurface, in: .capsule)
    }
}
