import BeautifulUI
import SwiftUI

/// Native port of the reference `Fine-tune` inspector.
struct ReferenceFineTuneDemo: View {
    @Environment(\.beautifulTheme) private var theme
    @State private var layout = 0
    @State private var width = 324
    @State private var height = 96
    @State private var radius = 28
    @State private var opacity = 100
    @State private var selectedType = "Select type"
    @State private var showsTypeMenu = false

    private var isEdited: Bool {
        layout != 0 || width != 324 || height != 96 || radius != 28 || opacity != 100 || selectedType != "Select type"
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Flavor card").font(.system(size: 13, weight: .medium))
                Spacer()
                if isEdited {
                    Label("Edited", systemImage: "checkmark")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(theme.positive)
                        .transition(.opacity.combined(with: .scale(scale: 0.85)))
                } else {
                    HStack(spacing: 6) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundStyle(theme.accent)
                            .frame(width: 18, height: 18)
                            .background(theme.accent.opacity(0.14), in: .rect(cornerRadius: 5))
                        BeautifulShimmerText("Adjust", font: .system(size: 12, weight: .medium))
                    }
                }
            }
            .padding(.horizontal, 12)
            .frame(height: 36)
            .overlay(alignment: .bottom) { Rectangle().fill(theme.border).frame(height: 1) }

            VStack(alignment: .leading, spacing: 8) {
                Text("Layout").font(.system(size: 12.5, weight: .medium))
                HStack(spacing: 2) {
                    ForEach(["row", "col", "grid"].indices, id: \.self) { index in
                        Button {
                            layout = index
                        } label: {
                            ReferenceFineTuneLayoutIcon(kind: ["row", "col", "grid"][index])
                                .foregroundStyle(layout == index ? theme.accent : Color.secondary)
                                .frame(maxWidth: .infinity, minHeight: 24)
                                .background(layout == index ? theme.surface : .clear, in: .rect(cornerRadius: 6))
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("\(["row", "column", "grid"][index]) layout")
                    }
                }
                .padding(2)
                .background(theme.elevatedSurface, in: .rect(cornerRadius: 7))
                .overlay(RoundedRectangle(cornerRadius: 7).stroke(theme.border, lineWidth: 1))

                HStack(spacing: 8) {
                    ReferenceFineTuneField(label: "W", value: $width, range: 40 ... 999, isActive: width != 324)
                    ReferenceFineTuneField(label: "H", value: $height, range: 24 ... 999, isActive: height != 96)
                }
                HStack(spacing: 8) {
                    ReferenceFineTuneField(label: "Radius", value: $radius, range: 0 ... 64, isActive: radius != 28)
                    ReferenceFineTuneField(label: "Opacity", value: $opacity, range: 0 ... 100, suffix: "%", isActive: opacity != 100)
                }
            }
            .padding(12)
            .overlay(alignment: .bottom) { Rectangle().fill(theme.border).frame(height: 1) }

            HStack {
                Text("Type").font(.system(size: 12)).foregroundStyle(.tertiary)
                Spacer()
                Menu {
                    ForEach(["Seasonal", "Classic", "Limited"], id: \.self) { type in
                        Button(type) { selectedType = type }
                    }
                } label: {
                    HStack(spacing: 6) {
                        Text(selectedType).lineLimit(1)
                        Image(systemName: "chevron.down").font(.system(size: 10, weight: .bold))
                    }
                    .font(.system(size: 12))
                    .foregroundStyle(selectedType == "Select type" ? Color.secondary : Color.primary)
                    .padding(.horizontal, 8)
                    .frame(height: 26)
                    .background(theme.elevatedSurface, in: .capsule)
                    .overlay(Capsule().stroke(theme.border, lineWidth: 1))
                }
                .menuStyle(.borderlessButton)
            }
            .padding(.horizontal, 12)
            .frame(height: 40)
        }
        .frame(width: 240)
        .background(theme.surface, in: .rect(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(theme.border, lineWidth: 1))
        .shadow(color: .black.opacity(0.16), radius: 12, y: 4)
        .animation(.timingCurve(0.23, 1, 0.32, 1, duration: 0.25), value: isEdited)
    }
}

private struct ReferenceFineTuneField: View {
    let label: String
    @Binding var value: Int
    let range: ClosedRange<Int>
    var suffix = ""
    let isActive: Bool
    @Environment(\.beautifulTheme) private var theme

    var body: some View {
        HStack(spacing: 4) {
            Text(label).foregroundStyle(.tertiary)
            TextField(label, value: $value, format: .number)
                .textFieldStyle(.plain)
                .font(.system(size: 12))
                .multilineTextAlignment(.trailing)
                .onChange(of: value) { _, newValue in value = min(range.upperBound, max(range.lowerBound, newValue)) }
            if !suffix.isEmpty { Text(suffix).font(.system(size: 11.5)).foregroundStyle(.tertiary) }
        }
        .padding(.horizontal, 6)
        .frame(height: 26)
        .background(isActive ? theme.accent.opacity(0.14) : theme.elevatedSurface, in: .capsule)
        .overlay(Capsule().stroke(isActive ? theme.accent : .clear, lineWidth: 1))
    }
}

private struct ReferenceFineTuneLayoutIcon: View {
    let kind: String
    var body: some View {
        Group {
            switch kind {
            case "row": HStack(spacing: 2) { ForEach(0 ..< 3, id: \.self) { _ in square } }
            case "col": VStack(spacing: 2) { ForEach(0 ..< 2, id: \.self) { _ in square } }
            default: VStack(spacing: 2) { HStack(spacing: 2) { square; square }; HStack(spacing: 2) { square; square } }
            }
        }
    }
    private var square: some View { RoundedRectangle(cornerRadius: 1).stroke(lineWidth: 1.2).frame(width: 6, height: 6) }
}
