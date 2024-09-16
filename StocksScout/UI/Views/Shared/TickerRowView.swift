//
//  TickerRowView.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/13/24.
//

import Foundation
import SwiftUI

struct TickerRowView: View {
    let ticker: TickerResult
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(ticker.ticker)
                .bold()
            Text(ticker.name)
        }
    }
}
