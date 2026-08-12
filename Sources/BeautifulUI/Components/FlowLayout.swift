import SwiftUI

struct FlowLayout: Layout {
    let spacing: CGFloat

    init(spacing: CGFloat = BeautifulMetrics.compact) {
        self.spacing = spacing
    }

    func makeCache(subviews: Subviews) -> FlowLayoutCache {
        FlowLayoutCache(subviewSizes: subviews.map { $0.sizeThatFits(.unspecified) })
    }

    func updateCache(_ cache: inout FlowLayoutCache, subviews: Subviews) {
        cache = makeCache(subviews: subviews)
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout FlowLayoutCache) -> CGSize {
        let rows = rows(for: proposal.width, cache: &cache)
        let contentHeight = rows.reduce(CGFloat.zero) { partialResult, row in
            partialResult + row.height
        }
        let rowSpacing = max(CGFloat.zero, CGFloat(rows.count - 1) * spacing)
        let height = contentHeight + rowSpacing
        let intrinsicWidth = rows.map { $0.width }.max() ?? .zero
        let width = proposal.width ?? intrinsicWidth
        return CGSize(width: width, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout FlowLayoutCache) {
        var origin = bounds.origin
        for row in rows(for: bounds.width, cache: &cache) {
            origin.x = bounds.minX
            for (index, size) in zip(row.indices, row.sizes) {
                subviews[index].place(at: origin, proposal: ProposedViewSize(size))
                origin.x += size.width + spacing
            }
            origin.y += row.height + spacing
        }
    }

    private func rows(for proposedWidth: CGFloat?, cache: inout FlowLayoutCache) -> [FlowLayoutRow] {
        if cache.hasResolvedRows, cache.proposedWidth == proposedWidth {
            return cache.rows
        }

        let maxWidth = proposedWidth ?? .greatestFiniteMagnitude
        var rows: [FlowLayoutRow] = []
        var current = FlowLayoutRow(indices: [], sizes: [], width: 0, height: 0)
        for (index, size) in cache.subviewSizes.enumerated() {
            let nextWidth = current.indices.isEmpty ? size.width : current.width + spacing + size.width
            if nextWidth > maxWidth && !current.indices.isEmpty {
                rows.append(current)
                current = FlowLayoutRow(indices: [index], sizes: [size], width: size.width, height: size.height)
            } else {
                current.indices.append(index)
                current.sizes.append(size)
                current.width = nextWidth
                current.height = max(current.height, size.height)
            }
        }
        if !current.indices.isEmpty {
            rows.append(current)
        }
        cache.proposedWidth = proposedWidth
        cache.rows = rows
        cache.hasResolvedRows = true
        return rows
    }
}
