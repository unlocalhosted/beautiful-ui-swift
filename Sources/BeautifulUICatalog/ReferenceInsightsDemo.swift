import BeautifulUI
import Charts
import SwiftUI

/// Native port of the reference `Insights` carousel and its three interactive cards.
struct ReferenceInsightsDemo: View {
    @Environment(\.beautifulTheme) private var theme
    @State private var selectedInsight = 0
    @State private var selectedAllocation = "VAN"
    @State private var expenseMode = "Spend"

    private let allocation = [
        ReferenceAllocation(name: "VAN", label: "Vanilla", percentage: 72.5, amount: "$51,785", tint: .orange),
        ReferenceAllocation(name: "CHOC", label: "Chocolate", percentage: 22.8, amount: "$16,278", tint: .secondary),
        ReferenceAllocation(name: "MINT", label: "Mint", percentage: 4.7, amount: "$3,357", tint: .secondary.opacity(0.6))
    ]

    private var selectedAllocationValue: ReferenceAllocation {
        allocation.first(where: { $0.name == selectedAllocation }) ?? allocation[0]
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                HStack(alignment: .firstTextBaseline, spacing: 6) {
                    Text("Insights").font(.system(size: 13, weight: .semibold))
                    Text("3").font(.system(size: 13)).foregroundStyle(.tertiary)
                }
                Spacer()
                Button { selectedInsight = (selectedInsight + 2) % 3 } label: { Image(systemName: "chevron.left").frame(width: 24, height: 24) }
                    .buttonStyle(ReferenceInsightIconStyle()).accessibilityLabel("Previous insight")
                Button { selectedInsight = (selectedInsight + 1) % 3 } label: { Image(systemName: "chevron.right").frame(width: 24, height: 24) }
                    .buttonStyle(ReferenceInsightIconStyle()).accessibilityLabel("Next insight")
            }

            Group {
                switch selectedInsight {
                case 0: compareInsight
                case 1: freezerInsight
                default: allocationInsight
                }
            }
            .id(selectedInsight)
            .transition(.opacity)
            .padding(.top, 6)

            Button(followUp) {}
                .font(.system(size: 12))
                .foregroundStyle(.primary)
                .padding(.horizontal, 12)
                .frame(height: 28)
                .background(theme.surface, in: .capsule)
                .overlay(Capsule().stroke(theme.border, lineWidth: 1))
                .buttonStyle(.plain)
                .padding(.top, 8)
        }
        .frame(maxWidth: 344, minHeight: 408, alignment: .topLeading)
        .animation(.easeOut(duration: 0.25), value: selectedInsight)
    }

    private var compareInsight: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 0) {
                Text("The worst performer in your ")
                Text("● @Creamery").foregroundStyle(theme.warning).fontWeight(.medium)
                Text(" is Rocky Road — down ")
                Text("-6%").foregroundStyle(theme.negative).font(.system(size: 11.5, design: .monospaced))
                Text(" or ")
                Text("-$2,453.44").foregroundStyle(theme.negative).font(.system(size: 11.5, design: .monospaced))
                Text(".")
            }
            .font(.system(size: 12.5))
            .foregroundStyle(.secondary)

            VStack(spacing: 0) {
                HStack(spacing: 16) {
                    metric(name: "Mint Chip", delta: "-4.41%", amount: "-$2,377.66", tint: theme.warning)
                    metric(name: "Pistachio", delta: "+1.15%", amount: "$617.22", tint: theme.accent)
                }
                .padding(.bottom, 8)
                chartShell(title: "Trend snapshot", badge: "Snapshot") {
                    ForEach(Array(Self.mint.enumerated()), id: \.offset) { index, value in
                        LineMark(x: .value("Index", index), y: .value("Mint", value))
                            .foregroundStyle(theme.warning)
                            .interpolationMethod(.catmullRom)
                            .lineStyle(.init(lineWidth: 2.25))
                    }
                    ForEach(Array(Self.pistachio.enumerated()), id: \.offset) { index, value in
                        LineMark(x: .value("Index", index), y: .value("Pistachio", value))
                            .foregroundStyle(theme.accent)
                            .interpolationMethod(.catmullRom)
                            .lineStyle(.init(lineWidth: 2.25))
                    }
                }
            }
            .padding(12)
            .background(theme.surface, in: .rect(cornerRadius: 12))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(theme.border, lineWidth: 1))
        }
    }

    private var freezerInsight: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 0) {
                Text("Unusually high freezer bill on ")
                Text("Dec 13").fontWeight(.medium).foregroundStyle(.primary)
                Text(" — ")
                Text("+$1,834.66").foregroundStyle(theme.negative).font(.system(size: 11.5, design: .monospaced))
                Text(" above your average.")
            }
            .font(.system(size: 12.5)).foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Label("High freezer spend", systemImage: "arrow.up")
                        .font(.system(size: 12, weight: .medium)).foregroundStyle(.primary)
                    Spacer()
                    Text("Snapshot").font(.system(size: 10.5, weight: .medium)).foregroundStyle(.secondary).padding(.horizontal, 8).frame(height: 20).background(theme.elevatedSurface, in: .capsule)
                }
                .padding(.bottom, 8)
                chartShell(title: expenseMode == "Spend" ? "$2,112 threshold" : "82 kWh threshold", badge: nil) {
                    ForEach(Array((expenseMode == "Spend" ? Self.freezerSpend : Self.freezerUsage).enumerated()), id: \.offset) { index, value in
                        LineMark(x: .value("Index", index), y: .value("Value", value))
                            .foregroundStyle(theme.negative)
                            .interpolationMethod(.catmullRom)
                            .lineStyle(.init(lineWidth: 2.25))
                    }
                }
                HStack(spacing: 2) {
                    ForEach(["Spend", "Usage"], id: \.self) { mode in
                        Button(mode) { expenseMode = mode }
                            .font(.system(size: 10.5, weight: .medium))
                            .foregroundStyle(expenseMode == mode ? Color.primary : Color.secondary)
                            .padding(.horizontal, 8)
                            .frame(height: 20)
                            .background(expenseMode == mode ? theme.surface : .clear, in: .capsule)
                            .buttonStyle(.plain)
                    }
                }
                .padding(2).background(theme.elevatedSurface, in: .capsule).padding(.top, 6)
            }
            .padding(12).background(theme.surface, in: .rect(cornerRadius: 12)).overlay(RoundedRectangle(cornerRadius: 12).stroke(theme.border, lineWidth: 1))
        }
    }

    private var allocationInsight: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 0) {
                Text("You're heavily invested in ")
                Text("● @Vanilla").foregroundStyle(theme.warning).fontWeight(.medium)
                Text(" — it's ")
                Text("72.5%").foregroundStyle(.primary).fontWeight(.medium)
                Text(" of your case.")
            }
            .font(.system(size: 12.5)).foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 0) {
                Label("Vanilla allocation", systemImage: "v.circle.fill")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.primary)
                Text(selectedAllocationValue.amount)
                    .font(.system(size: 20, weight: .semibold)).padding(.top, 3)
                HStack(spacing: 2) {
                    ForEach(allocation) { segment in
                        Button { selectedAllocation = segment.name } label: {
                            Capsule().fill(segment.tint).opacity(selectedAllocation == segment.name ? 1 : 0.58)
                                .overlay { if selectedAllocation == segment.name { Capsule().stroke(.white.opacity(0.22), lineWidth: 1) } }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 32)
                        .buttonStyle(.plain)
                    }
                }
                .padding(2).background(theme.elevatedSurface, in: .capsule).padding(.top, 12)
                HStack(spacing: 4) {
                    ForEach(allocation) { segment in
                        Button("● \(segment.name) \(segment.percentage, specifier: "%.1f")%") { selectedAllocation = segment.name }
                            .font(.system(size: 11))
                            .foregroundStyle(selectedAllocation == segment.name ? Color.primary : Color.secondary)
                            .padding(.horizontal, 6).frame(height: 22)
                            .background(selectedAllocation == segment.name ? theme.elevatedSurface : .clear, in: .capsule)
                            .buttonStyle(.plain)
                    }
                }
                .padding(.top, 6)
                VStack(alignment: .leading, spacing: 4) {
                    Text(selectedAllocationValue.label).font(.system(size: 11.5, weight: .medium)).foregroundStyle(selectedAllocationValue.tint)
                    Text("Contribution snapshot across current inventory value. Segment selection changes the inspected group without moving the card.")
                        .font(.system(size: 11)).foregroundStyle(.tertiary).lineSpacing(2)
                }
                .padding(10).background(theme.elevatedSurface, in: .rect(cornerRadius: 7)).padding(.top, 10)
            }
            .padding(12).background(theme.surface, in: .rect(cornerRadius: 12)).overlay(RoundedRectangle(cornerRadius: 12).stroke(theme.border, lineWidth: 1))
        }
    }

    private func metric(name: String, delta: String, amount: String, tint: Color) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Label(name, systemImage: "circle.fill").font(.system(size: 11.5)).foregroundStyle(.secondary)
            Text(delta).font(.system(size: 17, weight: .semibold)).foregroundStyle(tint)
            Text(amount).font(.system(size: 11.5, design: .monospaced)).foregroundStyle(tint)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }

    private func chartShell<Content: ChartContent>(title: String, badge: String?, @ChartContentBuilder content: () -> Content) -> some View {
        VStack(spacing: 0) {
            HStack {
                Text(title).font(.system(size: 11)).foregroundStyle(.tertiary)
                Spacer()
                if let badge { Text(badge).font(.system(size: 10.5, weight: .medium)).foregroundStyle(.secondary).padding(.horizontal, 8).frame(height: 20).background(theme.surface, in: .capsule) }
            }
            .padding(.horizontal, 10).frame(height: 30).overlay(alignment: .bottom) { Rectangle().fill(theme.border).frame(height: 1) }
            Chart(content: content)
                .chartLegend(.hidden).chartXAxis(.hidden).chartYAxis(.hidden)
                .frame(height: 136).padding(.horizontal, 4).padding(.vertical, 6)
        }
        .background(theme.elevatedSurface, in: .rect(cornerRadius: 7))
        .overlay(RoundedRectangle(cornerRadius: 7).stroke(theme.border, lineWidth: 1))
    }

    private var followUp: String {
        ["Should I rebalance flavors?", "Get tips on cutting freezer costs", "If we look at seasonals, what changes?"][selectedInsight]
    }

    private static let mint = [-2.9, -3.4, -3.05, -3.86, -3.52, -4.1, -3.82, -4.41]
    private static let pistachio = [0.22, 0.58, 0.42, 0.91, 0.76, 1.08, 0.96, 1.15]
    private static let freezerSpend = [274.0, 289, 264, 307, 331, 1210, 1718, 2112]
    private static let freezerUsage = [18.0, 19, 17, 21, 22, 58, 81, 96]
}

private struct ReferenceAllocation: Identifiable {
    let name: String
    let label: String
    let percentage: Double
    let amount: String
    let tint: Color
    var id: String { name }
}

private struct ReferenceInsightIconStyle: ButtonStyle {
    @Environment(\.beautifulTheme) private var theme
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.foregroundStyle(.tertiary).background(configuration.isPressed ? theme.elevatedSurface : .clear, in: .rect(cornerRadius: 6))
    }
}
