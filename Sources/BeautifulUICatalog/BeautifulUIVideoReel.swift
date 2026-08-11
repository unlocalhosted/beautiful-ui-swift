import BeautifulUI
import SwiftUI

/// Full-screen, self-running presentation of every native BeautifulUI primitive.
///
/// Launch the demo apps with `--video-demo` to use this presentation surface.
public struct BeautifulUIVideoReel: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var store = CatalogStore()
    @State private var reelIndex = 0

    private var section: CatalogSection {
        CatalogSection.allCases[reelIndex]
    }

    public init() {}

    public var body: some View {
        VStack(spacing: 0) {
            header

            CatalogComponentPreview(section: section, store: store)
                .id(section)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(BeautifulTheme.reference.sidebar)
        .environment(\.beautifulTheme, BeautifulTheme.reference)
        .preferredColorScheme(.dark)
#if os(iOS)
        .statusBarHidden(true)
#endif
        .tint(BeautifulTheme.reference.accent)
        .task(id: reelIndex) {
            await advanceWhenReady()
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 10) {
                Image(systemName: "sparkle")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.primary)
                    .accessibilityHidden(true)

                Text("BEAUTIFUL UI")
                    .font(.caption.weight(.semibold))
                    .tracking(1.4)

                Spacer()

                Text("\(section.number) / \(CatalogSection.allCases.count)")
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(.secondary)
            }

            Text(section.title)
                .font(.title2.weight(.semibold))

            Text(section.subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(2)

            ProgressView(
                value: Double(reelIndex + 1),
                total: Double(CatalogSection.allCases.count)
            )
            .tint(BeautifulTheme.reference.accent)
            .accessibilityLabel("Primitive \(section.number) of \(CatalogSection.allCases.count): \(section.title)")
        }
        .padding(.horizontal, 24)
        .padding(.top, 24)
        .padding(.bottom, 18)
    }

    @MainActor
    private func advanceWhenReady() async {
        guard !reduceMotion, reelIndex < CatalogSection.allCases.count - 1 else { return }

        do {
            try await Task.sleep(for: presentationDuration)
        } catch {
            return
        }

        guard !Task.isCancelled else { return }
        withAnimation(.easeInOut(duration: 0.24)) {
            reelIndex += 1
        }
    }

    private var presentationDuration: Duration {
        switch section {
        case .thinking, .chat:
            .seconds(5)
        case .tasks:
            .seconds(6)
        case .tools:
            .seconds(4)
        case .loading, .streaming, .approval, .prompt, .recommendation,
                .changes, .records, .insights, .code, .fineTune, .selection:
            .seconds(section == .selection ? 6 : 4)
        case .context, .filters, .workspace, .search:
            .seconds(3)
        }
    }
}

#Preview {
    BeautifulUIVideoReel()
}
