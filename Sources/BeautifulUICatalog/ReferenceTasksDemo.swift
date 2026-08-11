import BeautifulUI
import SwiftUI

/// Native port of the reference `Task` primitive, with the staged failure and
/// recovery sequence retained for both Capsules and List presentations.
struct ReferenceTasksDemo: View {
    let variant: ReferenceTaskVariant

    @Environment(\.accessibilityReduceMotion) private var reducesMotion
    @Environment(\.beautifulTheme) private var theme
    @State private var phase = 0
    @State private var expanded: [String: Bool] = [:]

    private let phaseDelays = [600, 900, 2_400, 1_400, 2_400, 600]

    private var draftStatus: ReferenceTaskStatus {
        if phase < 3 { .pending }
        else if phase == 3 { .failed }
        else { .complete }
    }

    private var tasks: [ReferenceTask] {
        [
            .init(key: "verify", label: "Verified vendor records", amount: "12 suppliers", status: .complete, details: [
                .init(label: "Matched tax and contact IDs", meta: "12/12"),
                .init(label: "Flagged stale records", meta: "0")
            ]),
            .init(key: "index", label: "Build reorder task list", amount: "7 SKUs", status: .running, details: [
                .init(label: "Reading POS export", meta: "3 files"),
                .init(label: "Scoring stockout risk", meta: "68%")
            ]),
            .init(key: "draft", label: "Draft supplier emails", amount: "2 messages", status: draftStatus, details: [
                .init(label: "Cone supplier follow-up", meta: "draft"),
                .init(label: "Pistachio reorder note", meta: "draft")
            ])
        ]
    }

    var body: some View {
        VStack(spacing: variant == .list ? 0 : 8) {
            ForEach(Array(tasks.enumerated()), id: \.element.key) { index, task in
                taskCard(task, index: index)
            }
        }
        .background(variant == .list ? theme.surface : .clear, in: .rect(cornerRadius: variant == .list ? 12 : 0))
        .overlay {
            if variant == .list {
                RoundedRectangle(cornerRadius: 12).stroke(theme.border, lineWidth: 1)
            }
        }
        .frame(maxWidth: 440, minHeight: variant == .capsules ? 196 : nil, alignment: .topLeading)
        .animation(.timingCurve(0.23, 1, 0.32, 1, duration: 0.3), value: phase)
        .task(id: variant) { await playSequence() }
    }

    private func taskCard(_ task: ReferenceTask, index: Int) -> some View {
        let defaultExpanded = task.key == "index" && phase == 2
        let isExpanded = expanded[task.key] ?? defaultExpanded
        return VStack(spacing: 0) {
            Button {
                expanded[task.key] = !isExpanded
            } label: {
                HStack(spacing: 10) {
                    ReferenceTaskBadge(status: task.status)
                        .frame(width: 24, height: 24)

                    Text(task.label)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                    Spacer(minLength: 0)
                    Text(task.amount)
                        .font(.system(size: 12.5))
                        .foregroundStyle(.secondary)
                        .monospacedDigit()
                        .lineLimit(1)
                    if let badge = task.status.badgeTitle {
                        HStack(spacing: 6) {
                            Text(badge)
                            if task.status == .failed {
                                Image(systemName: "arrow.clockwise")
                                    .font(.system(size: 10, weight: .medium))
                                    .rotationEffect(.degrees(phase == 3 ? 360 : 0))
                            }
                        }
                        .font(.system(size: 11.5, weight: .medium))
                        .foregroundStyle(task.status == .failed ? theme.negative : theme.positive)
                        .padding(.horizontal, 8)
                        .frame(height: 22)
                        .background((task.status == .failed ? theme.negative : theme.positive).opacity(0.14), in: .capsule)
                    }
                    Image(systemName: "chevron.down")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(.tertiary)
                        .frame(width: 20, height: 28)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                }
                .frame(height: 44)
                .padding(.horizontal, 10)
                .contentShape(.rect)
            }
            .buttonStyle(ReferenceTaskButtonStyle())

            if isExpanded {
                HStack(alignment: .top, spacing: 10) {
                    Rectangle()
                        .fill(theme.border)
                        .frame(width: 1)
                        .frame(maxHeight: .infinity)
                        .frame(width: 24)
                    VStack(alignment: .leading, spacing: 6) {
                        ForEach(Array(task.details.enumerated()), id: \.element.label) { detailIndex, detail in
                            HStack {
                                Text(detail.label)
                                    .font(.system(size: 12))
                                    .foregroundStyle(.secondary)
                                Spacer(minLength: 0)
                                Text(detail.meta)
                                    .font(.system(size: 11.5, design: .monospaced))
                                    .foregroundStyle(.tertiary)
                            }
                            .transition(.opacity.combined(with: .offset(y: 5)))
                            .animation(.timingCurve(0.23, 1, 0.32, 1, duration: 0.3).delay(0.12 + Double(detailIndex) * 0.1), value: isExpanded)
                        }
                    }
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .background(variant == .capsules ? theme.surface : .clear, in: .rect(cornerRadius: variant == .capsules ? (isExpanded ? 14 : 22) : 0))
        .overlay(alignment: .bottom) {
            if variant == .list && index < tasks.count - 1 { Rectangle().fill(theme.border).frame(height: 1) }
        }
        .overlay {
            if variant == .capsules { RoundedRectangle(cornerRadius: isExpanded ? 14 : 22).stroke(theme.border, lineWidth: 1) }
        }
        .transition(.opacity.combined(with: .offset(y: 8)))
    }

    private func playSequence() async {
        await MainActor.run {
            phase = reducesMotion ? phaseDelays.count - 1 : 0
            expanded = [:]
        }
        guard !reducesMotion else { return }
        for index in phaseDelays.indices.dropLast() {
            do { try await Task.sleep(for: .milliseconds(phaseDelays[index])) }
            catch { return }
            guard !Task.isCancelled else { return }
            await MainActor.run {
                withAnimation(.timingCurve(0.23, 1, 0.32, 1, duration: 0.3)) { phase = index + 1 }
            }
        }
    }
}

private struct ReferenceTask {
    let key: String
    let label: String
    let amount: String
    let status: ReferenceTaskStatus
    let details: [ReferenceTaskDetail]
}

private struct ReferenceTaskDetail {
    let label: String
    let meta: String
}

private enum ReferenceTaskStatus: Equatable {
    case pending, running, failed, complete

    var badgeTitle: String? {
        switch self {
        case .failed: "Failed"
        case .complete: "Completed"
        case .pending, .running: nil
        }
    }
}

private struct ReferenceTaskBadge: View {
    let status: ReferenceTaskStatus
    @Environment(\.beautifulTheme) private var theme

    var body: some View {
        Group {
            switch status {
            case .complete:
                Image(systemName: "checkmark")
                    .font(.system(size: 11, weight: .black))
                    .foregroundStyle(.white)
                    .background(theme.positive, in: .circle)
            case .failed:
                Image(systemName: "xmark")
                    .font(.system(size: 10, weight: .black))
                    .foregroundStyle(.white)
                    .background(theme.negative, in: .circle)
            case .pending:
                Text("3")
                    .font(.system(size: 10.5, weight: .semibold))
                    .foregroundStyle(.primary)
                    .overlay(Circle().stroke(theme.border, lineWidth: 2))
            case .running:
                ZStack {
                    Circle().stroke(theme.border, lineWidth: 2)
                    Circle()
                        .trim(from: 0, to: 0.28)
                        .stroke(Color.secondary, style: .init(lineWidth: 2, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    Text("2")
                        .font(.system(size: 10.5, weight: .semibold))
                }
                .rotationEffect(.degrees(status == .running ? 360 : 0))
            }
        }
        .frame(width: 22, height: 22)
    }
}

private struct ReferenceTaskButtonStyle: ButtonStyle {
    @Environment(\.beautifulTheme) private var theme
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.background(configuration.isPressed ? theme.elevatedSurface : .clear)
    }
}
