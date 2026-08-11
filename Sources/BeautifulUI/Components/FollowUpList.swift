import SwiftUI

struct FollowUpList: View {
    let followUps: [String]
    let onFollowUp: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: BeautifulMetrics.compact) {
            Text("Follow-ups")
                .font(.system(size: 11.5))
                .foregroundStyle(.secondary)
            ForEach(followUps, id: \.self) { followUp in
                Button(followUp, action: { onFollowUp(followUp) })
                    .buttonStyle(BeautifulSecondaryButtonStyle())
                    .frame(minHeight: BeautifulMetrics.controlHeight)
            }
        }
    }
}
