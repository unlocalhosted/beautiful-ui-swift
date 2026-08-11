import SwiftUI

struct ReferenceDemoActions: View {
    var body: some View {
        HStack(spacing: 4) {
            Button("Copy source", systemImage: "doc.on.doc", action: {})
            Button("View source", systemImage: "chevron.left.forwardslash.chevron.right", action: {})
        }
        .labelStyle(.iconOnly)
        .font(.system(size: 12, weight: .medium))
        .foregroundStyle(.secondary)
        .buttonStyle(ReferenceIconButtonStyle())
        .accessibilityElement(children: .contain)
    }
}
