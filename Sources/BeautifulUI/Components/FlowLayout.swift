import SwiftUI

struct FlowLayout: Layout {
    let spacing: CGFloat

    init(spacing: CGFloat = BeautifulMetrics.compact) {
        self.spacing = spacing
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let rows = rows(for: proposal.width, subviews: subviews)
        let contentHeight = rows.reduce(CGFloat.zero) { partialResult, row in
            partialResult + row.height
        }
        let rowSpacing = max(CGFloat.zero, CGFloat(rows.count - 1) * spacing)
        let height = contentHeight + rowSpacing
        let intrinsicWidth = rows.map { $0.width }.max() ?? .zero
        let width = proposal.width ?? intrinsicWidth
        return CGSize(width: width, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var origin = bounds.origin
        for row in rows(for: bounds.width, subviews: subviews) {
            origin.x = bounds.minX
            for index in row.indices {
                let size = subviews[index].sizeThatFits(.unspecified)
                subviews[index].place(at: origin, proposal: ProposedViewSize(size))
                origin.x += size.width + spacing
            }
            origin.y += row.height + spacing
        }
    }

    private func rows(for proposedWidth: CGFloat?, subviews: Subviews) -> [FlowLayoutRow] {
        let maxWidth = proposedWidth ?? .greatestFiniteMagnitude
        var rows: [FlowLayoutRow] = []
        var current = FlowLayoutRow(indices: [], width: 0, height: 0)
        for index in subviews.indices {
            let size = subviews[index].sizeThatFits(.unspecified)
            let nextWidth = current.indices.isEmpty ? size.width : current.width + spacing + size.width
            if nextWidth > maxWidth && !current.indices.isEmpty {
                rows.append(current)
                current = FlowLayoutRow(indices: [index], width: size.width, height: size.height)
            } else {
                current.indices.append(index)
                current.width = nextWidth
                current.height = max(current.height, size.height)
            }
        }
        if !current.indices.isEmpty {
            rows.append(current)
        }
        return rows
    }
}
