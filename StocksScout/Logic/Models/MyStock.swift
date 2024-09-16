//
//  Stock.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/10/24.
//

import Foundation
import SwiftData

@Model
final class MyStock {
    @Attribute(.unique) var ticker: String
    var tickerInfo: TickerResult
    var previousClose: AggregateResult?
    var tickerDetails: TickerDetailsResult?
    @Relationship(deleteRule: .cascade) var aggregatesResults: [AggregateResult]?

    init(tickerInfo: TickerResult) {
        self.ticker = tickerInfo.ticker
        self.tickerInfo = tickerInfo
    }
}
