import SwiftUI

/// Explicit human approval UI. Host apps choose what submission means and can enforce their own policy.
public struct ApprovalCard: View {
    public let request: ApprovalRequest
    public let onSubmit: (ApprovalDecision) -> Void
    public let onDismiss: () -> Void

    @State private var selectedOptionID: ApprovalOption.ID?
    @State private var customResponse = ""

    public init(
        request: ApprovalRequest,
        onSubmit: @escaping (ApprovalDecision) -> Void,
        onDismiss: @escaping () -> Void = {}
    ) {
        self.request = request
        self.onSubmit = onSubmit
        self.onDismiss = onDismiss
    }

    public var body: some View {
        BeautifulSurface {
            VStack(alignment: .leading, spacing: BeautifulMetrics.roomy) {
                HStack(alignment: .top) {
                    Text(request.prompt)
                        .font(.system(size: 13, weight: .semibold))
                    Spacer()
                    Button("Dismiss", systemImage: "xmark", action: onDismiss)
                        .labelStyle(.iconOnly)
                        .buttonStyle(BeautifulIconButtonStyle())
                }
                ApprovalOptionList(
                    options: request.options,
                    selectedOptionID: $selectedOptionID
                )
                if request.allowsCustomResponse {
                    TextField("Custom answer", text: $customResponse, axis: .vertical)
                        .lineLimit(2...4)
                        .textFieldStyle(.plain)
                        .font(.system(size: 12.5))
                        .padding(10)
                        .background(.quaternary.opacity(0.35), in: .rect(cornerRadius: 8))
                }
                HStack {
                    Spacer()
                    Button("Approve", systemImage: "checkmark", action: submit)
                        .buttonStyle(BeautifulPrimaryButtonStyle())
                        .disabled(selectedOptionID == nil && customResponse.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }

    private func submit() {
        if let selectedOption = request.options.first(where: { $0.id == selectedOptionID }) {
            onSubmit(.option(selectedOption))
        } else {
            onSubmit(.custom(customResponse.trimmingCharacters(in: .whitespacesAndNewlines)))
        }
    }
}

#Preview {
    ApprovalCard(
        request: .init(
            prompt: "How many flavors should we launch?",
            options: [.init(title: "Three", detail: "Core line"), .init(title: "Five", detail: "Full case")]
        ),
        onSubmit: { _ in }
    )
    .padding()
}
