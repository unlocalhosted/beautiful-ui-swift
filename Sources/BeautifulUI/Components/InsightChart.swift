import Charts
import SwiftUI

struct InsightChart: View {
    let series: [[Double]]

    var body: some View {
        Chart {
            ForEach(series.indices, id: \.self) { seriesIndex in
                ForEach(series[seriesIndex].indices, id: \.self) { pointIndex in
                    LineMark(
                        x: .value("Index", pointIndex),
                        y: .value("Value", series[seriesIndex][pointIndex])
                    )
                    .foregroundStyle(by: .value("Series", seriesIndex))
                    .interpolationMethod(.catmullRom)
                }
            }
        }
        .chartLegend(.hidden)
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .frame(height: 130)
        .accessibilityLabel("Trend snapshot chart")
    }
}
