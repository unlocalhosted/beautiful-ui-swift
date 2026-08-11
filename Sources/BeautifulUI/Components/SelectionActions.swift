import SwiftUI

/// A keyboard-accessible action bar for selected text; host receives a semantic intent, not edited text.
public struct SelectionActions: View {
    public let selectedText: String
    @Binding public var instruction: String
    public let onAction: (SelectionAction) -> Void
    public let onSend: () -> Void

    public init(
        selectedText: String,
        instruction: Binding<String>,
        onAction: @escaping (SelectionAction) -> Void,
        onSend: @escaping () -> Void
    ) {
        self.selectedText = selectedText
        _instruction = instruction
        self.onAction = onAction
        self.onSend = onSend
    }

    public var body: some View {
        BeautifulSurface {
            VStack(alignment: .leading, spacing: BeautifulMetrics.regular) {
                Text(selectedText)
                    .font(.system(size: 13))
                    .lineSpacing(2)
                    .textSelection(.enabled)
                SelectionActionToolbar(onAction: onAction)
                HStack(spacing: BeautifulMetrics.compact) {
                    TextField("Describe edits", text: $instruction)
                        .textFieldStyle(.plain)
                        .font(.system(size: 12.5))
                        .padding(.horizontal, 10)
                        .frame(height: BeautifulMetrics.controlHeight)
                        .background(.quaternary.opacity(0.32), in: .rect(cornerRadius: 8))
                    Button("Send edit instruction", systemImage: "arrow.up", action: onSend)
                        .labelStyle(.iconOnly)
                        .buttonStyle(BeautifulPrimaryButtonStyle())
                        .disabled(instruction.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

#Preview {
    SelectionActions(selectedText: "Pistachio holds the top slot all weekend.", instruction: .constant(""), onAction: { _ in }, onSend: {})
        .padding()
}
