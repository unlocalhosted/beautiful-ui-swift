import SwiftUI

struct FlowLayoutCache {
    var proposedWidth: CGFloat?
    var subviewSizes: [CGSize]
    var rows: [FlowLayoutRow] = []
    var hasResolvedRows = false
}
