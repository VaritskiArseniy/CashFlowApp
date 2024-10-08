import Foundation
import DGCharts

/// Info bubble VM factory
struct ChartInfoBubbleVmFactory {
    private let entry: ChartDataEntry
    private let chartDatasetVMs: [ChartDataSetVM]

    init(
        entry: ChartDataEntry,
        chartDatasetVMs: [ChartDataSetVM]
    ) {
        self.entry = entry
        self.chartDatasetVMs = chartDatasetVMs
    }

    func makeInfoBubbleVM() -> ChartInfoBubbleViewModel {
        let dateTitle = entry.data as? String ?? ""
        let converter = ChartInfoBubbleDataRowConverter()
        let position = Int(entry.x)
        let dataRows = converter.convert(
            dataSetVMs: chartDatasetVMs,
            position: position
        )

        return ChartInfoBubbleViewModel(title: dateTitle, dataSet: dataRows)
    }
}
