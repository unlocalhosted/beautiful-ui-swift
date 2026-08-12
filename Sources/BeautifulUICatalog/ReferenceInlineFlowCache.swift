import SwiftUI

struct ReferenceInlineFlowCache {
    var proposedWidth: CGFloat?
    var subviewSizes: [CGSize]
    var lines: [ReferenceInlineFlowLine] = []
    var hasResolvedLines = false
}
