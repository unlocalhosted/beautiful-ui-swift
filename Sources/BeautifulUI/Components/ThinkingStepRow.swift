import SwiftUI

struct ThinkingStepRow: View {
    let step: ThinkingStep

    var body: some View {
        HStack(alignment: .top, spacing: 7) {
            Image(systemName: step.kind.symbolName)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.secondary)
                .frame(width: 16)
            VStack(alignment: .leading, spacing: BeautifulMetrics.micro) {
                HStack(spacing: 7) {
                    Text(step.title)
                        .font(.system(size: 12.5, weight: .medium))
                    if let duration = step.duration {
                        Text(duration.formatted(.units(allowed: [.seconds], width: .abbreviated)))
                            .font(.system(size: 11.5))
                            .foregroundStyle(.secondary)
                    }
                }
                Text(step.detail)
                    .font(.system(size: 11.5))
                    .foregroundStyle(.secondary)
            }
        }
        .accessibilityElement(children: .combine)
    }
}
