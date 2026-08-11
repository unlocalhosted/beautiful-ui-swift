import SwiftUI

struct FineTuneSlider<Format: ParseableFormatStyle>: View where Format.FormatInput == Double, Format.FormatOutput == String {
    let label: String
    @Binding var value: Double
    let range: ClosedRange<Double>
    let format: Format

    var body: some View {
        LabeledContent(label) {
            HStack {
                Slider(value: $value, in: range)
                Text(value, format: format)
                    .font(.system(size: 11.5, design: .monospaced))
                    .monospacedDigit()
                    .frame(minWidth: 42, alignment: .trailing)
            }
        }
    }
}
