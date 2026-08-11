import BeautifulUI
import SwiftUI

/// Native port of the reference `Chat` primitive's deterministic response loop.
struct ReferenceChatDemo: View {
    private enum ResponseState: Equatable { case done, sent, replyOne, replyTwo }

    @Environment(\.beautifulTheme) private var theme
    @State private var responseState: ResponseState = .done
    @State private var draft = ""
    @State private var lastMessage = "Compare mint chip to last summer"
    @State private var selectedTab = "Flavors"

    private var hasUserMessage: Bool { true }
    private var hasFirstReply: Bool { responseState == .replyOne || responseState == .replyTwo || responseState == .done }
    private var hasSecondReply: Bool { responseState == .replyTwo || responseState == .done }
    private var canSend: Bool { !draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }

    var body: some View {
        VStack(spacing: 0) {
            header

            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    if hasUserMessage {
                        HStack {
                            Spacer(minLength: 56)
                            Text(lastMessage)
                                .font(.system(size: 13))
                                .foregroundStyle(.primary)
                                .lineSpacing(2)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(theme.elevatedSurface, in: .rect(cornerRadius: 12))
                                .transition(.opacity.combined(with: .offset(y: 10)))
                        }
                    }

                    if hasFirstReply {
                        ReferenceChatReply(
                            label: "Sales History",
                            sublabel: "Flavor Data",
                            duration: "4s",
                            message: "Pulled 3 summers of mint chip sales for comparison."
                        )
                    }

                    if hasSecondReply {
                        ReferenceChatReply(
                            label: "Comparison",
                            sublabel: "Trend Detection",
                            duration: "2s",
                            message: "Mint chip is up 12% with stronger weekend peaks.",
                            isResolving: responseState == .replyTwo
                        )
                    }
                }
                .padding(.horizontal, 12)
                .padding(.top, 10)
                .padding(.bottom, 4)
            }

            composer
        }
        .frame(width: 380, height: 288, alignment: .top)
        .background(theme.surface, in: .rect(cornerRadius: 14))
        .overlay {
            RoundedRectangle(cornerRadius: 14).stroke(theme.border, lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.15), radius: 9, y: 3)
        .animation(.timingCurve(0.23, 1, 0.32, 1, duration: 0.4), value: responseState)
        .task(id: responseState) { await resolveResponse() }
    }

    private var header: some View {
        HStack {
            HStack(spacing: 0) {
                ForEach(["Flavors", "Suppliers"], id: \.self) { tab in
                    Button(tab) { selectedTab = tab }
                        .font(.system(size: 13))
                        .foregroundStyle(.primary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(selectedTab == tab ? theme.elevatedSurface : .clear, in: .rect(cornerRadius: 6))
                        .opacity(selectedTab == tab ? 1 : 0.5)
                        .buttonStyle(.plain)
                }
            }
            Spacer()
            HStack(spacing: 4) {
                ForEach(["plus", "clock", "ellipsis"], id: \.self) { symbol in
                    Button(action: {}) {
                        Image(systemName: symbol)
                            .font(.system(size: 12, weight: .medium))
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.tertiary)
                    }
                    .buttonStyle(ReferenceChatActionStyle())
                    .accessibilityLabel("Action")
                }
            }
        }
        .padding(6)
        .overlay(alignment: .bottom) { Rectangle().fill(theme.border).frame(height: 1) }
    }

    private var composer: some View {
        HStack(alignment: .bottom, spacing: 8) {
            TextField("Prompt or tag a flavor with @", text: $draft, axis: .vertical)
                .textFieldStyle(.plain)
                .font(.system(size: 13))
                .foregroundStyle(.primary)
                .lineLimit(1 ... 3)
                .onSubmit { send() }

            Button(action: send) {
                Image(systemName: "arrow.up")
                    .font(.system(size: 12, weight: .bold))
                    .frame(width: 28, height: 28)
                    .foregroundStyle(canSend ? theme.surface : Color.secondary)
                    .background(canSend ? Color.primary : theme.border, in: .rect(cornerRadius: 8))
            }
            .buttonStyle(.plain)
            .disabled(!canSend)
            .accessibilityLabel("Send")
        }
        .padding(10)
        .background(theme.elevatedSurface, in: .rect(cornerRadius: 8))
        .overlay { RoundedRectangle(cornerRadius: 8).stroke(theme.border, lineWidth: 1) }
        .padding(6)
    }

    private func send() {
        let message = draft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !message.isEmpty else { return }
        lastMessage = message
        draft = ""
        responseState = .sent
    }

    private func resolveResponse() async {
        let delay: Int?
        let next: ResponseState?
        switch responseState {
        case .sent: delay = 500; next = .replyOne
        case .replyOne: delay = 1_400; next = .replyTwo
        case .replyTwo: delay = 1_200; next = .done
        case .done: delay = nil; next = nil
        }
        guard let delay, let next else { return }
        do { try await Task.sleep(for: .milliseconds(delay)) }
        catch { return }
        guard !Task.isCancelled else { return }
        await MainActor.run { responseState = next }
    }
}

private struct ReferenceChatReply: View {
    let label: String
    let sublabel: String
    let duration: String
    let message: String
    var isResolving = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 4) {
                Text(label).font(.system(size: 12, weight: .medium))
                Text(sublabel).font(.system(size: 12)).foregroundStyle(.secondary)
                Text("for \(duration)").font(.system(size: 12))
            }
            Text(message)
                .font(.system(size: 13))
                .foregroundStyle(.primary)
                .lineSpacing(2)
        }
        .opacity(isResolving ? 0.55 : 1)
        .blur(radius: isResolving ? 0.5 : 0)
        .scaleEffect(isResolving ? 0.985 : 1, anchor: .topLeading)
        .transition(.opacity.combined(with: .offset(y: 6)))
    }
}

private struct ReferenceChatActionStyle: ButtonStyle {
    @Environment(\.beautifulTheme) private var theme
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.background(configuration.isPressed ? theme.elevatedSurface : .clear, in: .rect(cornerRadius: 6))
    }
}
