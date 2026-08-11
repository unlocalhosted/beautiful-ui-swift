import SwiftUI

/// A consistently padded and elevated container for AI work in progress or reviewable output.
public struct BeautifulSurface<Content: View>: View {
    private let content: Content
    private let padding: CGFloat

    @Environment(\.beautifulTheme) private var theme

    public init(padding: CGFloat = BeautifulMetrics.roomy, @ViewBuilder content: () -> Content) {
        self.padding = padding
        self.content = content()
    }

    public var body: some View {
        content
            .padding(padding)
            .background(theme.surface, in: .rect(cornerRadius: BeautifulMetrics.cornerRadius))
            .overlay {
                RoundedRectangle(cornerRadius: BeautifulMetrics.cornerRadius)
                    .stroke(theme.border, lineWidth: 1)
            }
    }
}

#Preview {
    BeautifulSurface {
        Text("A composed, native surface")
    }
    .padding()
}
