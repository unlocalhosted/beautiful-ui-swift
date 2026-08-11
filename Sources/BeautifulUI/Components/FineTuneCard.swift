import SwiftUI

/// A property inspector that keeps editing state in the host through a single binding.
public struct FineTuneCard: View {
    public let title: String
    @Binding public var values: FineTuneValues

    public init(title: String, values: Binding<FineTuneValues>) {
        self.title = title
        _values = values
    }

    public var body: some View {
        BeautifulSurface {
            VStack(alignment: .leading, spacing: BeautifulMetrics.roomy) {
                Text(title)
                    .font(.system(size: 13, weight: .semibold))
                FineTuneLayoutPicker(layout: $values.layout)
                FineTuneSlider(label: "Width", value: $values.width, range: 120...600, format: .number.precision(.fractionLength(0)))
                FineTuneSlider(label: "Height", value: $values.height, range: 44...420, format: .number.precision(.fractionLength(0)))
                FineTuneSlider(label: "Corner radius", value: $values.cornerRadius, range: 0...56, format: .number.precision(.fractionLength(0)))
                FineTuneSlider(label: "Opacity", value: $values.opacity, range: 0...1, format: .percent)
            }
        }
    }
}

#Preview {
    FineTuneCard(title: "Flavor card", values: .constant(.init()))
        .padding()
}
