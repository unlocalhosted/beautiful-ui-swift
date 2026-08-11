import SwiftUI

struct WorkspaceIdentity: View {
    let name: String
    let detail: String

    var body: some View {
        HStack(spacing: BeautifulMetrics.compact) {
            Text(String(name.prefix(1)).uppercased())
                .font(.system(size: 11.5, weight: .semibold))
                .frame(width: 28, height: 28)
                .background(.quaternary, in: .rect(cornerRadius: 7))
            VStack(alignment: .leading, spacing: BeautifulMetrics.micro) {
                Text(name)
                    .font(.system(size: 12.5, weight: .medium))
                Text(detail)
                    .font(.system(size: 11.5))
                    .foregroundStyle(.secondary)
            }
        }
        .accessibilityElement(children: .combine)
    }
}
