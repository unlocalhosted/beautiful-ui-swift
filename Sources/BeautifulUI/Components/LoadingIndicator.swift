import SwiftUI

struct LoadingIndicator: View {
    let style: LoadingStyle
    let reduceMotion: Bool

    var body: some View {
        PixelGridLoader(style: style, reducesMotion: reduceMotion)
    }
}
