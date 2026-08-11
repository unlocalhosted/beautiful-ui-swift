import BeautifulUI
import SwiftUI

struct CatalogNoticeBanner: View {
    let notice: String?
    let onDismiss: () -> Void

    var body: some View {
        if let notice {
            HStack {
                Label(notice, systemImage: "checkmark.circle.fill")
                    .font(.subheadline)
                    .foregroundStyle(.green)
                Spacer()
                Button("Dismiss", systemImage: "xmark", action: onDismiss)
                    .labelStyle(.iconOnly)
                    .buttonStyle(.borderless)
                    .frame(minWidth: BeautifulMetrics.controlHeight, minHeight: BeautifulMetrics.controlHeight)
            }
            .padding(BeautifulMetrics.regular)
            .background(.green.opacity(0.12), in: .rect(cornerRadius: BeautifulMetrics.regular))
            .transition(.opacity)
        }
    }
}
