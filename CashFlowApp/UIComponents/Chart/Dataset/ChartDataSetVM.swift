import Foundation
import DGCharts

/// Single chart data model
struct ChartDataSetVM {
    public let colorAsset: DataColor
    public let chartDataEntries: [ChartDataEntry]

    init(
        colorAsset: DataColor,
        chartDataEntries: [ChartDataEntry]
    ) {
        self.colorAsset = colorAsset
        self.chartDataEntries = chartDataEntries
    }
}
