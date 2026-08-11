import SwiftUI

struct ReferenceSectionNumber: View {
    let number: Int

    var body: some View {
        Text(number, format: .number.precision(.integerLength(2)))
            .font(.caption)
            .monospacedDigit()
            .foregroundStyle(.tertiary)
    }
}
