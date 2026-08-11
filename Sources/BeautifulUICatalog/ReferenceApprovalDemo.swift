import BeautifulUI
import SwiftUI

/// Native port of the reference `Approval` primitive, including its automatic
/// 480 ms radio-question advance and per-question answer retention.
struct ReferenceApprovalDemo: View {
    @Environment(\.beautifulTheme) private var theme
    @State private var currentQuestion = 0
    @State private var selectedOptions: [Int: Set<Int>] = [:]
    @State private var customAnswers: [Int: String] = [:]
    @State private var hasSentAnswers = false
    @State private var isOpen = true

    private let questions: [ReferenceApprovalQuestion] = [
        .init(prompt: "How many flavors should we launch?", kind: .radio, options: ["Three (core line)", "Five (full case)", "Just one hero"]),
        .init(prompt: "Which mix-ins should we stock?", kind: .check, options: ["Chocolate chips", "Waffle bits", "Sprinkles"]),
        .init(prompt: "Which market do we enter first?", kind: .radio, options: ["Food trucks", "Grocery freezers", "Scoop shops"])
    ]

    private var question: ReferenceApprovalQuestion { questions[currentQuestion] }
    private var isLastQuestion: Bool { currentQuestion == questions.count - 1 }
    private var hasAnswer: Bool {
        !(selectedOptions[currentQuestion] ?? []).isEmpty || !(customAnswers[currentQuestion] ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        Group {
            if isOpen {
                approvalCard
            } else {
                Button("Open approval") { isOpen = true }
                    .font(.system(size: 12.5, weight: .medium))
                    .buttonStyle(ReferenceApprovalOpenButtonStyle())
            }
        }
        .frame(maxWidth: 320, minHeight: 196, alignment: .topLeading)
    }

    private var approvalCard: some View {
        VStack(spacing: 0) {
            if hasSentAnswers {
                VStack(spacing: 8) {
                    Image(systemName: "checkmark")
                        .font(.system(size: 12, weight: .black))
                        .foregroundStyle(.white)
                        .frame(width: 24, height: 24)
                        .background(theme.positive, in: .circle)
                    Text("Answers sent")
                        .font(.system(size: 13, weight: .medium))
                    Button("Start over") { reset() }
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(theme.accent)
                        .buttonStyle(.plain)
                }
                .frame(maxWidth: .infinity, minHeight: 148)
                .transition(referenceFadeUp)
            } else {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .top, spacing: 12) {
                        Text(question.prompt)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(.primary)
                        Spacer(minLength: 0)
                        Button {
                            isOpen = false
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 11, weight: .bold))
                                .frame(width: 24, height: 24)
                        }
                        .buttonStyle(ReferenceApprovalDismissButtonStyle())
                        .accessibilityLabel("Dismiss")
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        ForEach(Array(question.options.enumerated()), id: \.offset) { index, option in
                            answerOption(option, at: index)
                        }
                        customAnswer
                    }
                    .padding(.top, 8)
                }
                .id(currentQuestion)
                .padding(14)
                .transition(referenceFadeUp)
            }

            approvalFooter
        }
        .background(theme.surface, in: .rect(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(theme.border, lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.15), radius: 9, y: 3)
        .animation(.timingCurve(0.23, 1, 0.32, 1, duration: 0.35), value: currentQuestion)
        .animation(.timingCurve(0.23, 1, 0.32, 1, duration: 0.30), value: hasSentAnswers)
    }

    private func answerOption(_ option: String, at index: Int) -> some View {
        let isSelected = selectedOptions[currentQuestion, default: []].contains(index)
        return Button {
            selectOption(index)
        } label: {
            HStack(spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: question.kind == .radio ? 8 : 5)
                        .fill(isSelected ? Color.primary : .clear)
                        .overlay {
                            RoundedRectangle(cornerRadius: question.kind == .radio ? 8 : 5)
                                .stroke(isSelected ? .clear : theme.border.opacity(1.5), lineWidth: 1.5)
                        }
                    if question.kind == .radio {
                        Circle()
                            .fill(theme.canvas)
                            .frame(width: 6, height: 6)
                            .scaleEffect(isSelected ? 1 : 0)
                    } else if isSelected {
                        Image(systemName: "checkmark")
                            .font(.system(size: 9, weight: .black))
                            .foregroundStyle(theme.canvas)
                    }
                }
                .frame(width: 16, height: 16)

                Text(option)
                    .font(.system(size: 13))
                    .foregroundStyle(isSelected ? Color.primary : Color.secondary)
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 4)
            .contentShape(.rect)
        }
        .buttonStyle(ReferenceApprovalOptionButtonStyle())
        .accessibilityValue(isSelected ? "Selected" : "Not selected")
    }

    private var customAnswer: some View {
        HStack(spacing: 8) {
            Color.clear.frame(width: 16, height: 16)
            TextField("Type something…", text: Binding(
                get: { customAnswers[currentQuestion, default: ""] },
                set: { value in
                    customAnswers[currentQuestion] = value
                    if question.kind == .radio { selectedOptions[currentQuestion] = [] }
                }
            ))
            .textFieldStyle(.plain)
            .font(.system(size: 13))
            .foregroundStyle(.primary)
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 4)
    }

    private var approvalFooter: some View {
        HStack {
            HStack(spacing: 8) {
                Button {
                    currentQuestion = max(0, currentQuestion - 1)
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 11, weight: .bold))
                        .frame(width: 24, height: 24)
                }
                .buttonStyle(ReferenceApprovalFooterButtonStyle())
                .disabled(currentQuestion == 0 || hasSentAnswers)

                HStack(spacing: 4) {
                    ForEach(questions.indices, id: \.self) { index in
                        Button {
                            currentQuestion = index
                        } label: {
                            Circle()
                                .strokeBorder(index == currentQuestion && !hasSentAnswers ? Color.primary : Color.secondary.opacity(index < currentQuestion || hasSentAnswers ? 0 : 0.85), lineWidth: index == currentQuestion && !hasSentAnswers ? 2.5 : 1.5)
                                .background(Circle().fill(index < currentQuestion || hasSentAnswers ? Color.secondary : .clear))
                                .frame(width: index == currentQuestion && !hasSentAnswers ? 9 : 7, height: index == currentQuestion && !hasSentAnswers ? 9 : 7)
                        }
                        .buttonStyle(.plain)
                        .disabled(hasSentAnswers)
                    }
                }

                Button {
                    currentQuestion = min(questions.count - 1, currentQuestion + 1)
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 11, weight: .bold))
                        .frame(width: 24, height: 24)
                }
                .buttonStyle(ReferenceApprovalFooterButtonStyle())
                .disabled(isLastQuestion || hasSentAnswers)
            }

            Spacer()

            if !hasSentAnswers {
                Button {
                    if isLastQuestion {
                        hasSentAnswers = true
                    } else {
                        currentQuestion += 1
                    }
                } label: {
                    Image(systemName: "arrow.up")
                        .font(.system(size: 12, weight: .bold))
                        .frame(width: 28, height: 28)
                        .foregroundStyle(hasAnswer ? theme.surface : Color.secondary)
                        .background(hasAnswer ? Color.primary : theme.elevatedSurface, in: .rect(cornerRadius: 8))
                }
                .buttonStyle(.plain)
                .disabled(!hasAnswer)
                .accessibilityLabel(isLastQuestion ? "Send answers" : "Next question")
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .overlay(alignment: .top) {
            Rectangle().fill(theme.border).frame(height: 1)
        }
    }

    private func selectOption(_ index: Int) {
        var answers = selectedOptions[currentQuestion, default: []]
        if question.kind == .radio {
            answers = [index]
            customAnswers[currentQuestion] = ""
        } else if answers.contains(index) {
            answers.remove(index)
        } else {
            answers.insert(index)
        }
        selectedOptions[currentQuestion] = answers

        guard question.kind == .radio else { return }
        let questionIndex = currentQuestion
        Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(480))
            guard currentQuestion == questionIndex, !Task.isCancelled else { return }
            if isLastQuestion {
                hasSentAnswers = true
            } else {
                currentQuestion += 1
            }
        }
    }

    private func reset() {
        currentQuestion = 0
        selectedOptions = [:]
        customAnswers = [:]
        hasSentAnswers = false
        isOpen = true
    }

    private var referenceFadeUp: AnyTransition {
        .asymmetric(insertion: .opacity.combined(with: .offset(y: 6)), removal: .opacity)
    }
}

private struct ReferenceApprovalQuestion {
    enum Kind { case radio, check }
    let prompt: String
    let kind: Kind
    let options: [String]
}

private struct ReferenceApprovalOpenButtonStyle: ButtonStyle {
    @Environment(\.beautifulTheme) private var theme
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.primary)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(configuration.isPressed ? theme.elevatedSurface : theme.surface, in: .rect(cornerRadius: 7))
    }
}

private struct ReferenceApprovalDismissButtonStyle: ButtonStyle {
    @Environment(\.beautifulTheme) private var theme
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.background(configuration.isPressed ? theme.elevatedSurface : .clear, in: .rect(cornerRadius: 6))
    }
}

private struct ReferenceApprovalOptionButtonStyle: ButtonStyle {
    @Environment(\.beautifulTheme) private var theme
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.background(configuration.isPressed ? theme.elevatedSurface : .clear, in: .rect(cornerRadius: 7))
    }
}

private struct ReferenceApprovalFooterButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.beautifulTheme) private var theme
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(isEnabled ? Color.secondary : Color.secondary.opacity(0.35))
            .background(configuration.isPressed ? theme.elevatedSurface : .clear, in: .rect(cornerRadius: 5))
    }
}
