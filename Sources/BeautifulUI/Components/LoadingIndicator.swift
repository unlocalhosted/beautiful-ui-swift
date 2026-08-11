import SwiftUI

struct LoadingIndicator: View {
    let style: LoadingStyle
    let reduceMotion: Bool

    var body: some View {
        switch style {
        case .grid:
            if reduceMotion {
                Image(systemName: "square.grid.2x2.fill")
            } else {
                Image(systemName: "square.grid.2x2.fill")
                    .symbolEffect(.pulse, options: .repeating)
            }
        case .dots:
            ProgressView()
                .controlSize(.small)
        case .orbit:
            if reduceMotion {
                Image(systemName: "circle.dotted")
            } else {
                Image(systemName: "circle.dotted")
                    .symbolEffect(.rotate, options: .repeating)
            }
        }
    }
}
