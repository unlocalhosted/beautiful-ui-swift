import BeautifulUI
import SwiftUI

struct ReferenceShowcaseHeader: View {
    let section: CatalogSection

    var body: some View {
        ViewThatFits(in: .horizontal) {
            HStack(alignment: .firstTextBaseline, spacing: BeautifulMetrics.compact) {
                ReferenceSectionNumber(number: section.number)
                Text(section.title)
                    .font(.system(size: 13, weight: .semibold))
                Text(section.subtitle)
                    .font(.system(size: 12.5))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                Spacer(minLength: 0)
            }
            VStack(alignment: .leading, spacing: BeautifulMetrics.micro) {
                HStack(spacing: BeautifulMetrics.compact) {
                    ReferenceSectionNumber(number: section.number)
                    Text(section.title)
                        .font(.system(size: 13, weight: .semibold))
                }
                Text(section.subtitle)
                    .font(.system(size: 12.5))
                    .foregroundStyle(.secondary)
            }
        }
    }
}
