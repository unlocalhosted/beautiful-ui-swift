import BeautifulUI
import SwiftUI

struct ReferenceCatalogFooter: View {
    @State private var email = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("New components, occasionally.")
                .font(.system(size: 12.5))
                .foregroundStyle(.secondary)
            Text("Get updates when a new primitive lands.")
                .font(.system(size: 18, weight: .semibold))
            Text("No noise. Only components for agents talking to people.")
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
            HStack(spacing: BeautifulMetrics.compact) {
                TextField("you@studio.com", text: $email)
                    .textFieldStyle(.plain)
                    .padding(.horizontal, BeautifulMetrics.regular)
                    .frame(minHeight: BeautifulMetrics.controlHeight)
                    .background(BeautifulTheme.reference.surface, in: .rect(cornerRadius: BeautifulMetrics.compact))
                Button("Notify me", systemImage: "arrow.right", action: {})
                    .buttonStyle(.borderedProminent)
                    .disabled(email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
        .padding(32)
    }
}
