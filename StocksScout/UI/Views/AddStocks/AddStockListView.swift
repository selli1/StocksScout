//
//  AddStockListView.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/13/24.
//

import Foundation
import SwiftUI
import SwiftData

struct AddStockViewList: View {
    @Query private var tickers: [TickerResult]
    private var onSelect: (TickerResult) -> Void
    
    init(_ queryText: String, onSelect: @escaping (TickerResult) -> Void) {
        let uppercasedQuery = queryText.uppercased()
        self._tickers = Query(filter: #Predicate<TickerResult> { tickerResult in
            tickerResult.ticker.contains(uppercasedQuery) ||
            tickerResult.name.contains(queryText)
        }, sort: \TickerResult.ticker)
        self.onSelect = onSelect
    }
    func lowercasedString(_ string: String) -> String {
        return string.lowercased()
    }
    
    var body: some View {
        List(tickers) { ticker in
            Button(action: { onSelect(ticker) }) {
                TickerRowView(ticker: ticker)
            }
        }
    }
}
