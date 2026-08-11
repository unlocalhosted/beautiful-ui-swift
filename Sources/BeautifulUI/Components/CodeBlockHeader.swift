import SwiftUI

struct CodeBlockHeader: View {
    let filename: String
    let language: String
    let onCopy: () -> Void

    var body: some View {
        HStack {
            Label(filename, systemImage: "chevron.left.forwardslash.chevron.right")
                .font(.system(size: 12.5, weight: .medium))
            Spacer()
            Text(language)
                .font(.system(size: 11.5))
                .foregroundStyle(.secondary)
            Button("Copy code", systemImage: "doc.on.doc", action: onCopy)
                .labelStyle(.iconOnly)
                .buttonStyle(BeautifulIconButtonStyle())
        }
        .padding(.horizontal, BeautifulMetrics.regular)
        .background(.quaternary.opacity(0.45))
    }
}
