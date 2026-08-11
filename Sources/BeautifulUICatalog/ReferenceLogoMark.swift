import SwiftUI

struct ReferenceLogoMark: View {
    var body: some View {
        Image(systemName: "sparkle")
            .symbolRenderingMode(.hierarchical)
            .font(.system(size: 30, weight: .medium))
            .frame(width: 56, height: 56)
            .foregroundStyle(.primary)
            .accessibilityLabel("Beautiful UI")
    }
}
