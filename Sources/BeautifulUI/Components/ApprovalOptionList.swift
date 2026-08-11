import SwiftUI

struct ApprovalOptionList: View {
    let options: [ApprovalOption]
    @Binding var selectedOptionID: ApprovalOption.ID?

    var body: some View {
        VStack(alignment: .leading, spacing: BeautifulMetrics.compact) {
            ForEach(options) { option in
                Button(action: { selectedOptionID = option.id }) {
                    HStack(spacing: BeautifulMetrics.compact) {
                        Image(systemName: selectedOptionID == option.id ? "largecircle.fill.circle" : "circle")
                            .font(.system(size: 13))
                            .foregroundStyle(selectedOptionID == option.id ? Color.accentColor : Color.secondary)
                        VStack(alignment: .leading, spacing: BeautifulMetrics.micro) {
                            Text(option.title)
                                .font(.system(size: 12.5, weight: .medium))
                            if let detail = option.detail {
                                Text(detail)
                                    .font(.system(size: 11.5))
                                    .foregroundStyle(.secondary)
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 8)
                    .frame(minHeight: BeautifulMetrics.controlHeight)
                    .background {
                        if selectedOptionID == option.id {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.accentColor.opacity(0.14))
                        }
                    }
                }
                .buttonStyle(.plain)
                .accessibilityAddTraits(selectedOptionID == option.id ? .isSelected : [])
            }
        }
    }
}
