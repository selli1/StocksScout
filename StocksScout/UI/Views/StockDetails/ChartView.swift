//
//  ChartView.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/13/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    let aggregates: [AggregateResult]
    let gradient = Gradient(colors: [Color.accentColor.opacity(0.4), Color.accentColor.opacity(0)])
    
    var body: some View {
        Chart {
            ForEach(aggregates, id: \.timestamp) { aggregate in
                LineMark(x: .value("time", aggregate.timestamp),
                         y: .value("price", aggregate.openPrice))
            }
            ForEach(aggregates, id: \.timestamp) { aggregate in
                AreaMark(x: .value("time", aggregate.timestamp),
                         y: .value("price", aggregate.openPrice))
            }
            .foregroundStyle(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
            .alignsMarkStylesWithPlotArea()
        }
        .frame(height: 300)
        .chartXScale(domain: chartXScaleDomain().0...chartXScaleDomain().1)
        .chartYScale(domain: chartYScaleDomain().0...chartYScaleDomain().1)
        .chartLegend(.hidden)
        .chartXAxis(.hidden)
        .chartYAxis {
            AxisMarks {
                AxisValueLabel()
                    .foregroundStyle(.white)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
    
    func chartXScaleDomain() -> (Int64, Int64) {
        let beginning = aggregates.first?.timestamp ?? 0
        let end = aggregates.last?.timestamp ?? 1
        return (beginning, end)
    }
    
    func chartYScaleDomain() -> (Double, Double) {
        let high = aggregates.max { (a, b) -> Bool in a.highPrice < b.highPrice }?.highPrice
        let low = aggregates.min { (a, b) -> Bool in a.lowPrice < b.lowPrice }?.lowPrice
        let padding = (high ?? 0) / 40
        let beginning = low ?? 0
        let end = high ?? 1
        return (beginning - padding, end + padding)
    }
}
