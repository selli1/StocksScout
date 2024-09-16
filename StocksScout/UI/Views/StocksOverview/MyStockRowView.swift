//
//  MyStockRowView.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/13/24.
//

import SwiftUI

struct MyStockRowView: View {
    let stock: MyStock
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(stock.tickerInfo.ticker)
                    .bold()
                Text(stock.tickerInfo.name)
            }
            Spacer()
            if let closeInfo = stock.previousClose {
                let delta = closeInfo.closePrice - closeInfo.openPrice
                VStack(alignment: .trailing) {
                    Text("\(closeInfo.closePrice)")
                        .bold()
                    GroupBox {
                        Text("\(delta)")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .bold()
                    }
                    .backgroundStyle(delta > 0 ? .green : .scoutOrange)
                }
            }
        }
        .frame(minHeight: 92)
    }
}
