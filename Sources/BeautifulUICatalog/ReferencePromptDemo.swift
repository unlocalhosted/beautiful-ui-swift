import BeautifulUI
import SwiftUI

/// Native port of the reference prompt-bar geometry and its source/model/dictation controls.
struct ReferencePromptDemo: View {
    let variant: ReferencePromptVariant

    @Environment(\.beautifulTheme) private var theme
    @State private var draft = ""
    @State private var attachments: [String] = []
    @State private var showsSourceMenu = false
    @State private var showsModelMenu = false
    @State private var selectedModel = "Vanilla 1"
    @State private var isDictating = false

    private let sourceOptions = ["Flavor brief.pdf", "Supplier inventory.csv", "Sales dashboard", "@Aurora Scoops"]
    private let models = ["Vanilla 1", "Sprinkles 5", "Pistachio Pro"]

    private var isPill: Bool { variant == .pill }
    private var canSend: Bool { !draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || !attachments.isEmpty }
    private var sourceSuggestions: [String] {
        let lower = draft.lowercased()
        guard lower.last == "@" || lower.contains(" @") else { return [] }
        return sourceOptions
    }

    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment: .bottomTrailing) {
                if showsSourceMenu || !sourceSuggestions.isEmpty {
                    suggestionMenu
                        .offset(y: -78)
                }
                if showsModelMenu {
                    modelMenu
                        .offset(y: -74)
                }
                composer
            }
        }
        .frame(maxWidth: 420, minHeight: 384)
        .padding(.bottom, 32)
    }

    private var composer: some View {
        VStack(spacing: 6) {
            if !attachments.isEmpty {
                HStack(spacing: 6) {
                    ForEach(attachments, id: \.self) { attachment in
                        HStack(spacing: 6) {
                            Image(systemName: "doc")
                            Text(attachment).lineLimit(1)
                            Button { attachments.removeAll { $0 == attachment } } label: {
                                Image(systemName: "xmark").font(.system(size: 9, weight: .bold))
                            }
                            .buttonStyle(.plain)
                        }
                        .font(.system(size: 11.5))
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 6)
                        .frame(height: 26)
                        .background(theme.elevatedSurface, in: .capsule)
                        .overlay(Capsule().stroke(theme.border, lineWidth: 1))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, isPill ? 4 : 2)
                .transition(.opacity.combined(with: .scale(scale: 0.95)))
            }

            HStack(alignment: .bottom, spacing: 4) {
                Button { toggleSourceMenu() } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .medium))
                        .frame(width: 28, height: 28)
                        .foregroundStyle(showsSourceMenu ? Color.primary : Color.secondary)
                        .background(showsSourceMenu ? theme.elevatedSurface : .clear, in: .rect(cornerRadius: isPill ? 14 : 8))
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Add attachments and sources")

                TextField(isDictating ? "Listening…" : "Write a message…", text: $draft, axis: .vertical)
                    .textFieldStyle(.plain)
                    .font(.system(size: 13))
                    .foregroundStyle(.primary)
                    .lineLimit(1 ... 4)
                    .onSubmit { send() }

                Button { showsModelMenu.toggle(); showsSourceMenu = false } label: {
                    HStack(spacing: 4) {
                        Text(selectedModel)
                        Image(systemName: "chevron.down").font(.system(size: 10, weight: .bold))
                    }
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.secondary)
                    .frame(height: 28)
                    .padding(.horizontal, 6)
                }
                .buttonStyle(ReferencePromptControlStyle(cornerRadius: isPill ? 14 : 8))
                .accessibilityLabel("Choose model")

                Button { isDictating.toggle() } label: {
                    Group {
                        if isDictating { ReferencePromptEqualizer() }
                        else { Image(systemName: "microphone") }
                    }
                    .font(.system(size: 15, weight: .medium))
                    .frame(width: 28, height: 28)
                    .foregroundStyle(isDictating ? theme.accent : Color.secondary)
                    .background(isDictating ? theme.accent.opacity(0.14) : .clear, in: .rect(cornerRadius: isPill ? 14 : 8))
                }
                .buttonStyle(.plain)
                .accessibilityLabel(isDictating ? "Stop dictation" : "Start dictation")

                Button(action: send) {
                    Image(systemName: "arrow.up")
                        .font(.system(size: 12, weight: .bold))
                        .frame(width: 28, height: 28)
                        .foregroundStyle(canSend ? theme.surface : Color.secondary)
                        .background(canSend ? Color.primary : theme.border, in: .rect(cornerRadius: isPill ? 14 : 8))
                }
                .buttonStyle(.plain)
                .disabled(!canSend)
                .accessibilityLabel("Send")
            }
        }
        .padding(6)
        .background(theme.surface, in: .rect(cornerRadius: isPill && attachments.isEmpty ? 28 : 14))
        .overlay(RoundedRectangle(cornerRadius: isPill && attachments.isEmpty ? 28 : 14).stroke(theme.border, lineWidth: 1))
        .shadow(color: .black.opacity(0.15), radius: 9, y: 3)
        .animation(.easeOut(duration: 0.2), value: attachments)
    }

    private var suggestionMenu: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(sourceSuggestions.isEmpty ? sourceOptions : sourceSuggestions, id: \.self) { option in
                Button {
                    if option.hasSuffix(".pdf") || option.hasSuffix(".csv") { attachments.append(option) }
                    else { draft = "@\(option.dropFirst()) " }
                    showsSourceMenu = false
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: option.hasPrefix("@") ? "at" : "doc")
                            .frame(width: 18)
                        Text(option).font(.system(size: 12.5, weight: .medium))
                        Spacer()
                        Text(option.hasPrefix("@") ? "Source" : "Attach")
                            .font(.system(size: 12)).foregroundStyle(.tertiary)
                    }
                    .foregroundStyle(.primary)
                    .padding(.horizontal, 8)
                    .frame(height: 36)
                }
                .buttonStyle(ReferencePromptMenuRowStyle())
            }
            Text("Type to search sources & files")
                .font(.system(size: 11))
                .foregroundStyle(.tertiary)
                .padding(.horizontal, 8)
                .frame(height: 28)
                .overlay(alignment: .top) { Rectangle().fill(theme.border).frame(height: 1) }
        }
        .frame(width: 300)
        .background(theme.surface, in: .rect(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(theme.border, lineWidth: 1))
        .shadow(color: .black.opacity(0.2), radius: 12, y: 4)
    }

    private var modelMenu: some View {
        VStack(spacing: 0) {
            ForEach(models, id: \.self) { model in
                Button {
                    selectedModel = model
                    showsModelMenu = false
                } label: {
                    HStack {
                        Text(model).font(.system(size: 12.5, weight: .medium))
                        Spacer()
                        if model == selectedModel { Image(systemName: "checkmark").font(.system(size: 11, weight: .bold)) }
                    }
                    .foregroundStyle(.primary)
                    .padding(.horizontal, 8)
                    .frame(height: 30)
                }
                .buttonStyle(ReferencePromptMenuRowStyle())
            }
        }
        .frame(width: 176)
        .background(theme.surface, in: .rect(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(theme.border, lineWidth: 1))
        .shadow(color: .black.opacity(0.2), radius: 12, y: 4)
    }

    private func toggleSourceMenu() {
        showsSourceMenu.toggle()
        showsModelMenu = false
    }

    private func send() {
        guard canSend else { return }
        draft = ""
        attachments = []
        showsSourceMenu = false
        showsModelMenu = false
    }
}

private struct ReferencePromptEqualizer: View {
    @Environment(\.accessibilityReduceMotion) private var reducesMotion
    var body: some View {
        TimelineView(.animation(minimumInterval: reducesMotion ? 1 : 1 / 20)) { timeline in
            let time = timeline.date.timeIntervalSinceReferenceDate
            HStack(alignment: .center, spacing: 2.5) {
                ForEach(0 ..< 3, id: \.self) { index in
                    Capsule()
                        .frame(width: 2.5, height: reducesMotion ? 9 : 6 + abs(sin(time * 7 + Double(index) * 0.8)) * 8)
                }
            }
        }
    }
}

private struct ReferencePromptControlStyle: ButtonStyle {
    let cornerRadius: CGFloat
    @Environment(\.beautifulTheme) private var theme
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.background(configuration.isPressed ? theme.elevatedSurface : .clear, in: .rect(cornerRadius: cornerRadius))
    }
}

private struct ReferencePromptMenuRowStyle: ButtonStyle {
    @Environment(\.beautifulTheme) private var theme
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.background(configuration.isPressed ? theme.elevatedSurface : .clear, in: .rect(cornerRadius: 6))
    }
}
