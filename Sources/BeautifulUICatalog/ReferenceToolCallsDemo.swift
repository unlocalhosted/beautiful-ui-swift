import BeautifulUI
import SwiftUI

/// Native port of the reference `Tool` primitive's 700 ms staged call list.
struct ReferenceToolCallsDemo: View {
    @Environment(\.accessibilityReduceMotion) private var reducesMotion
    @Environment(\.beautifulTheme) private var theme
    @State private var visibleCallCount = 0
    @State private var isExpanded = true
    @State private var expandedCalls: Set<String> = []

    private let calls: [ReferenceToolCall] = [
        .init(icon: "sparkles", label: "Thinking", chip: "Planning the churn schedule…", details: [
            .init(text: "Weekend demand carries pistachio, so it churns first."),
            .init(text: "Batch capacity leaves two evening freezer windows.")
        ]),
        .init(icon: "pencil", label: "Write 204 lines", chip: "ChurnSchedule.tsx", isMonospaced: true, detailsAreMonospaced: true, details: [
            .init(text: "+ const windows = slots.filter((s) => s.temp <= -12)", tone: .addition),
            .init(text: "+ return schedule(windows, { hero: \"pistachio\" })", tone: .addition)
        ]),
        .init(icon: "terminal", label: "Rebuild and verify", chip: "npm run freeze", isMonospaced: true, detailsAreMonospaced: true, details: [
            .init(text: "✓ built in 1.2s"),
            .init(text: "✓ 34 checks passed")
        ]),
        .init(icon: "doc", label: "Read image", chip: "flavor-chart.png", isMonospaced: true, details: [
            .init(text: "1280 × 720 · line chart, three summers."),
            .init(text: "Mint chip trends up 12% through July.")
        ])
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                isExpanded.toggle()
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.down")
                        .font(.system(size: 10, weight: .bold))
                        .rotationEffect(.degrees(isExpanded ? 0 : -90))
                    Text("4 tool calls, 2 messages")
                        .font(.system(size: 12.5))
                        .monospacedDigit()
                }
                .foregroundStyle(.secondary)
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
            }
            .buttonStyle(.plain)

            if isExpanded {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(Array(calls.prefix(visibleCallCount))) { call in
                        toolCall(call)
                            .transition(.asymmetric(insertion: .opacity.combined(with: .offset(y: 6)), removal: .opacity))
                    }

                    if visibleCallCount >= calls.count + 1 {
                        HStack(spacing: 6) {
                            ForEach(Self.changedFiles) { file in
                                HStack(spacing: 6) {
                                    Text(file.name)
                                        .lineLimit(1)
                                    Text("+\(file.additions)")
                                        .foregroundStyle(theme.positive)
                                    if file.deletions > 0 {
                                        Text("−\(file.deletions)")
                                            .foregroundStyle(theme.negative)
                                    }
                                }
                                .font(.system(size: 11.5, design: .monospaced))
                                .padding(.horizontal, 8)
                                .frame(height: 28)
                                .background(theme.surface, in: .capsule)
                                .overlay(Capsule().stroke(theme.border, lineWidth: 1))
                            }
                            Button("+2 more") {}
                                .font(.system(size: 11.5, design: .monospaced))
                                .foregroundStyle(.tertiary)
                                .padding(.horizontal, 6)
                                .frame(height: 28)
                        }
                        .lineLimit(1)
                        .padding(.top, 10)
                        .overlay(alignment: .top) { Rectangle().fill(theme.border).frame(height: 1) }
                        .transition(.opacity.combined(with: .scale(scale: 0.96)))
                    }
                }
                .padding(.top, 6)
                .padding(.horizontal, 6)
                .padding(.bottom, 4)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .frame(maxWidth: 320, minHeight: 220, alignment: .topLeading)
        .animation(.timingCurve(0.23, 1, 0.32, 1, duration: 0.3), value: isExpanded)
        .animation(.timingCurve(0.23, 1, 0.32, 1, duration: 0.3), value: visibleCallCount)
        .task { await stageCalls() }
    }

    private func toolCall(_ call: ReferenceToolCall) -> some View {
        let isCallExpanded = expandedCalls.contains(call.label)
        return VStack(alignment: .leading, spacing: 0) {
            Button {
                if isCallExpanded { expandedCalls.remove(call.label) }
                else { expandedCalls.insert(call.label) }
            } label: {
                HStack(spacing: 8) {
                    ZStack {
                        Image(systemName: call.icon)
                            .font(.system(size: 12, weight: .medium))
                            .opacity(isCallExpanded ? 0 : 1)
                        Image(systemName: "chevron.down")
                            .font(.system(size: 10, weight: .bold))
                            .rotationEffect(.degrees(isCallExpanded ? 0 : -90))
                            .opacity(isCallExpanded ? 1 : 0)
                    }
                    .frame(width: 16, height: 16)
                    .foregroundStyle(.tertiary)

                    Text(call.label)
                        .font(.system(size: 12.5, weight: .medium))
                        .foregroundStyle(.primary)
                        .lineLimit(1)

                    Text(call.chip)
                        .font(call.isMonospaced ? .system(size: 11.5, design: .monospaced) : .system(size: 11.5))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .padding(.horizontal, 6)
                        .frame(height: 22)
                        .background(theme.elevatedSurface, in: .capsule)
                    Spacer(minLength: 0)
                }
                .frame(height: 28)
                .padding(.horizontal, 3)
                .contentShape(.rect)
            }
            .buttonStyle(ReferenceToolRowButtonStyle())

            if isCallExpanded {
                VStack(alignment: .leading, spacing: 2) {
                    ForEach(call.details) { detail in
                        Text(detail.text)
                            .font(call.detailsAreMonospaced ? .system(size: 11.5, design: .monospaced) : .system(size: 11.5))
                            .foregroundStyle(detail.tone == .addition ? theme.positive : Color.secondary)
                            .lineLimit(1)
                    }
                }
                .padding(.vertical, 4)
                .padding(.leading, 14)
                .padding(.horizontal, 14)
                .overlay(alignment: .leading) {
                    Rectangle().fill(theme.border).frame(width: 1)
                        .padding(.leading, 8)
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }

    private func stageCalls() async {
        await MainActor.run {
            visibleCallCount = reducesMotion ? calls.count + 1 : 0
            isExpanded = true
            expandedCalls = []
        }
        guard !reducesMotion else { return }
        while !Task.isCancelled, visibleCallCount < calls.count + 1 {
            do { try await Task.sleep(for: .milliseconds(700)) }
            catch { return }
            await MainActor.run {
                withAnimation(.timingCurve(0.23, 1, 0.32, 1, duration: 0.3)) {
                    visibleCallCount += 1
                }
            }
        }
    }

    private static let changedFiles = [
        ReferenceToolFile(name: "flavors.css", additions: 13, deletions: 0),
        ReferenceToolFile(name: "ChurnSchedule.tsx", additions: 74, deletions: 41),
        ReferenceToolFile(name: "menu.ts", additions: 8, deletions: 2)
    ]
}

private struct ReferenceToolCall: Identifiable {
    let id = UUID()
    let icon: String
    let label: String
    let chip: String
    var isMonospaced = false
    var detailsAreMonospaced = false
    let details: [ReferenceToolDetail]
}

private struct ReferenceToolDetail: Identifiable {
    enum Tone { case neutral, addition }
    let id = UUID()
    let text: String
    var tone: Tone = .neutral
}

private struct ReferenceToolFile: Identifiable {
    let id = UUID()
    let name: String
    let additions: Int
    let deletions: Int
}

private struct ReferenceToolRowButtonStyle: ButtonStyle {
    @Environment(\.beautifulTheme) private var theme
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.background(configuration.isPressed ? theme.elevatedSurface : .clear, in: .rect(cornerRadius: 7))
    }
}
