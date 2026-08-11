import BeautifulUI
import SwiftUI

/// Native port of the reference `Selection actions` workflow.
struct ReferenceSelectionDemo: View {
    private enum SelectionState { case idle, thinking, streaming, result }

    @Environment(\.accessibilityReduceMotion) private var reducesMotion
    @Environment(\.beautifulTheme) private var theme
    @State private var state: SelectionState = .idle
    @State private var instruction = ""
    @State private var showsMore = false
    @State private var toolbarVisible = false
    @State private var intent = "Improve"

    private let original = "Churn it first thing Saturday so the batch has time to firm up before the afternoon rush."
    private let revised = "Churn pistachio first thing Saturday so the batch has time to fully firm before the afternoon rush."

    private var displayedSelection: String {
        switch state {
        case .idle, .thinking: original
        case .streaming, .result: revised
        }
    }

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            Text("Pistachio holds the top slot all weekend. ")
                .font(.system(size: 13))
                .foregroundStyle(.primary)
            Text(displayedSelection)
                .font(.system(size: 13))
                .foregroundStyle(.primary)
                .background(theme.accent.opacity(0.14), in: .rect(cornerRadius: 3))
        }
        .lineSpacing(3)
        .frame(maxWidth: 460, minHeight: 96, alignment: .topLeading)
        .padding(.bottom, 48)
        .overlay(alignment: .bottom) {
            if toolbarVisible {
                toolbar
                    .transition(.opacity.combined(with: .scale(scale: 0.94)))
            }
        }
        .animation(.timingCurve(0.23, 1, 0.32, 1, duration: 0.32), value: state)
        .animation(.timingCurve(0.23, 1, 0.32, 1, duration: 0.22), value: toolbarVisible)
        .task {
            guard !reducesMotion else { toolbarVisible = true; return }
            try? await Task.sleep(for: .milliseconds(280))
            guard !Task.isCancelled else { return }
            toolbarVisible = true
        }
        .task(id: state) { await progress() }
    }

    private var toolbar: some View {
        HStack(spacing: 2) {
            switch state {
            case .thinking, .streaming:
                HStack(spacing: 6) {
                    ProgressView().controlSize(.mini)
                    BeautifulShimmerText("\(intent)ing…", font: .system(size: 12.5))
                }
                .padding(.horizontal, 10)
                .frame(height: 28)
            case .result:
                Button { reset() } label: { Label("Keep", systemImage: "checkmark") }
                    .foregroundStyle(theme.surface)
                    .padding(.horizontal, 10)
                    .frame(height: 28)
                    .background(Color.primary, in: .capsule)
                    .buttonStyle(.plain)
                Button("Discard") { reset() }
                    .padding(.horizontal, 10)
                    .frame(height: 28)
                    .buttonStyle(ReferenceSelectionActionStyle())
                Divider().frame(height: 16)
                Button { state = .thinking } label: { Image(systemName: "arrow.clockwise").frame(width: 28, height: 28) }
                    .buttonStyle(ReferenceSelectionActionStyle())
            case .idle:
                if !instruction.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    TextField("Describe edits", text: $instruction)
                        .textFieldStyle(.plain)
                        .font(.system(size: 12.5))
                        .frame(width: 145, height: 28)
                        .padding(.horizontal, 10)
                    Button { begin(instruction) } label: { Image(systemName: "arrow.up").frame(width: 28, height: 28) }
                        .foregroundStyle(theme.surface)
                        .background(Color.primary, in: .circle)
                        .buttonStyle(.plain)
                } else {
                    Button("Explain") {}
                        .buttonStyle(ReferenceSelectionActionStyle())
                    Button("Improve") { begin("Improve") }
                        .buttonStyle(ReferenceSelectionActionStyle())
                    if showsMore {
                        Button("Shorten") { begin("Shorten") }.buttonStyle(ReferenceSelectionActionStyle())
                        Button("Tone") { begin("Change tone") }.buttonStyle(ReferenceSelectionActionStyle())
                        Button("Grammar") { begin("Editing") }.buttonStyle(ReferenceSelectionActionStyle())
                    }
                    Divider().frame(height: 16)
                    Button { showsMore.toggle() } label: {
                        Image(systemName: "chevron.down")
                            .frame(width: 28, height: 28)
                            .rotationEffect(.degrees(showsMore ? 180 : 0))
                    }
                    .buttonStyle(ReferenceSelectionActionStyle())
                }
            }
        }
        .font(.system(size: 12.5))
        .padding(4)
        .background(theme.surface, in: .capsule)
        .overlay(Capsule().stroke(theme.border, lineWidth: 1))
        .shadow(color: .black.opacity(0.2), radius: 10, y: 3)
    }

    private func begin(_ action: String) {
        intent = action == "Change tone" ? "Chang" : action
        instruction = ""
        state = .thinking
    }

    private func progress() async {
        guard state == .thinking else { return }
        guard !reducesMotion else { state = .result; return }
        do { try await Task.sleep(for: .milliseconds(700)) }
        catch { return }
        guard !Task.isCancelled else { return }
        state = .streaming
        do { try await Task.sleep(for: .milliseconds(1_200)) }
        catch { return }
        guard !Task.isCancelled else { return }
        state = .result
    }

    private func reset() {
        state = .idle
        instruction = ""
        intent = "Improve"
    }
}

private struct ReferenceSelectionActionStyle: ButtonStyle {
    @Environment(\.beautifulTheme) private var theme
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 8)
            .foregroundStyle(.primary)
            .background(configuration.isPressed ? theme.elevatedSurface : .clear, in: .capsule)
    }
}
