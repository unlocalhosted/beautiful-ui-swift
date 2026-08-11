import SwiftUI

struct FilterTaskRow: View {
    let task: FilterTask

    var body: some View {
        HStack(spacing: BeautifulMetrics.compact) {
            VStack(alignment: .leading, spacing: BeautifulMetrics.micro) {
                Text(task.title)
                    .font(.system(size: 12.5, weight: .medium))
                Text(task.advisor)
                    .font(.system(size: 11.5))
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: BeautifulMetrics.micro) {
                Text(task.date, format: .dateTime.month(.abbreviated).day())
                    .font(.system(size: 11.5))
                    .foregroundStyle(.secondary)
                Text(task.state.title)
                    .font(.system(size: 11))
                    .padding(.horizontal, BeautifulMetrics.compact)
                    .padding(.vertical, BeautifulMetrics.micro)
                    .background(task.state == .completed ? Color.green.opacity(0.14) : task.state == .inProgress ? Color.indigo.opacity(0.14) : Color.orange.opacity(0.14), in: .rect(cornerRadius: 5))
            }
        }
        .padding(BeautifulMetrics.regular)
        .background(.quaternary.opacity(0.32), in: .rect(cornerRadius: 6))
        .accessibilityElement(children: .combine)
    }
}
