import SwiftUI

/// Flexible, native composer with optional attachment and dictation affordances.
public struct PromptBar: View {
    @Binding public var draft: String
    public let models: [String]
    @Binding public var selectedModel: String
    public let onAddAttachments: () -> Void
    public let onDictate: () -> Void
    public let onSend: () -> Void

    public init(
        draft: Binding<String>,
        models: [String] = [],
        selectedModel: Binding<String> = .constant(""),
        onAddAttachments: @escaping () -> Void = {},
        onDictate: @escaping () -> Void = {},
        onSend: @escaping () -> Void
    ) {
        _draft = draft
        self.models = models
        _selectedModel = selectedModel
        self.onAddAttachments = onAddAttachments
        self.onDictate = onDictate
        self.onSend = onSend
    }

    public var body: some View {
        HStack(alignment: .bottom, spacing: BeautifulMetrics.compact) {
            Button("Add attachments and sources", systemImage: "plus", action: onAddAttachments)
                .labelStyle(.iconOnly)
                .buttonStyle(BeautifulIconButtonStyle())
            TextField("Write a message…", text: $draft, axis: .vertical)
                .lineLimit(1...5)
                .textFieldStyle(.plain)
                .font(.system(size: 12.5))
            PromptModelPicker(models: models, selectedModel: $selectedModel)
            Button("Start dictation", systemImage: "mic", action: onDictate)
                .labelStyle(.iconOnly)
                .buttonStyle(BeautifulIconButtonStyle())
            Button("Send", systemImage: "arrow.up", action: onSend)
                .labelStyle(.iconOnly)
                .buttonStyle(BeautifulPrimaryButtonStyle())
                .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .padding(BeautifulMetrics.compact)
        .background(.quaternary.opacity(0.32), in: .rect(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.quaternary, lineWidth: 1)
        }
    }
}

#Preview {
    PromptBar(draft: .constant(""), onSend: {})
        .padding()
}
