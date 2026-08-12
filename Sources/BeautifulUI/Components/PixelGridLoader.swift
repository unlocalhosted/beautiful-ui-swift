import SwiftUI

/// Reference 3×3 pixel loader. Each pixel follows the original per-cell timing map.
struct PixelGridLoader: View {
    let style: LoadingStyle
    let reducesMotion: Bool

    private let driveDelays = (0..<9).map { index in
        let row = index / 3
        return ((index % 3) + abs(row - 1)) * 90
    }
    private let orbitOrder = [0, 1, 2, 5, 8, 7, 6, 3]

    var body: some View {
        TimelineView(.animation(minimumInterval: reducesMotion ? 1 : 1 / 30)) { timeline in
            let elapsed = timeline.date.timeIntervalSinceReferenceDate
            Canvas(opaque: false, colorMode: .nonLinear, rendersAsynchronously: true) { context, _ in
                for index in 0 ..< 9 {
                    let row = index / 3
                    let column = index % 3
                    let origin = CGPoint(x: Double(column) * 5.5, y: Double(row) * 5.5)
                    let pixel = Path(
                        roundedRect: .init(origin: origin, size: .init(width: 4, height: 4)),
                        cornerRadius: style == .dots ? 2 : 1
                    )
                    context.opacity = pixelOpacity(at: index, elapsed: elapsed)
                    context.fill(pixel, with: .color(.primary))
                }
            }
            .frame(width: 15, height: 15)
        }
        .frame(width: 15, height: 15)
        .accessibilityHidden(true)
    }

    private func pixelOpacity(at index: Int, elapsed: TimeInterval) -> Double {
        guard !reducesMotion else { return staticOpacity(at: index) }
        let configuration: (delay: Int?, duration: Double)
        switch style {
        case .grid, .dots:
            configuration = (driveDelays[index], 0.65)
        case .orbit:
            configuration = (orbitOrder.firstIndex(of: index).map { $0 * 110 }, 0.95)
        }
        guard let delay = configuration.delay else { return 0.07 }
        let shifted = elapsed - Double(delay) / 1_000
        let progress = shifted.truncatingRemainder(dividingBy: configuration.duration) / configuration.duration
        let normalized = progress < 0 ? progress + 1 : progress
        if (0.18...0.42).contains(normalized) {
            let pulseProgress = (normalized - 0.18) / 0.24
            return 0.15 + 0.85 * sin(pulseProgress * .pi)
        }
        return 0.15
    }

    private func staticOpacity(at index: Int) -> Double {
        style == .orbit && orbitOrder.firstIndex(of: index) == nil ? 0.07 : 0.38
    }
}
