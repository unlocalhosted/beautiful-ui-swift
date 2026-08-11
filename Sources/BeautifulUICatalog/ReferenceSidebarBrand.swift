import SwiftUI

struct ReferenceSidebarBrand: View {
    @Binding var usesDarkAppearance: Bool

    @Environment(\.beautifulTheme) private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center) {
                ReferenceLogoMark()
                Spacer(minLength: 12)
                ReferenceAppearanceControl(usesDarkAppearance: $usesDarkAppearance)
            }
            Text("Beautiful UI for AI-native interfaces.")
                .font(.system(size: 21, weight: .semibold))
                .tracking(-0.35)
                .foregroundStyle(.primary)
                .lineSpacing(1)
                .padding(.top, 30)
        }
        .padding(.bottom, 24)
        .overlay(alignment: .bottom) {
            Rectangle()
                .stroke(theme.border, style: StrokeStyle(lineWidth: 1, dash: [3, 3]))
                .frame(height: 1)
        }
    }
}
