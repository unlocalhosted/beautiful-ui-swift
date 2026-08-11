import SwiftUI

struct ToolCallRow: View {
    let call: ToolCall

    var body: some View {
        HStack(spacing: BeautifulMetrics.compact) {
            Image(systemName: call.kind.symbolName)
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
                .frame(width: 18)
            Text(call.title)
                .font(.system(size: 12.5, weight: .medium))
            Spacer(minLength: BeautifulMetrics.compact)
            if let detail = call.detail {
                Text(detail)
                    .font(.system(size: 11.5))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
        }
        .padding(BeautifulMetrics.compact)
        .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: BeautifulMetrics.compact))
        .accessibilityElement(children: .combine)
    }
}
