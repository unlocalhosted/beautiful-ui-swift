import SwiftUI

struct ReferenceSidebarFooter: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 3) {
                Text("Built by Turbo")
                    .font(.system(size: 12.5, weight: .medium))
                Text("Product design studio")
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
            }
            Text("Get expert product design for your business.")
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            Button("Book a call", systemImage: "arrow.right", action: {})
                .font(.system(size: 11.5, weight: .medium))
                .labelStyle(.titleAndIcon)
                .buttonStyle(ReferenceFooterButtonStyle())
        }
    }
}
