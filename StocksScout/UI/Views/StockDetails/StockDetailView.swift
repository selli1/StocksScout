//
//  StockDetailView.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/10/24.
//

/*
Detailed Stock Information Screen
Present detailed information for a specific stock, such as historical data charts, volume, and market cap, using basic graphical representations and standard UI elements.
*/

import SwiftUI

struct StockDetailView: View {
    
    let stock: MyStock

    @EnvironmentObject var dataManager: APIDataManager
    
    @State private var aggregatesResponse: AggregateResponse?
    
    var body: some View {
        VStack {
            if let aggregateResults = aggregatesResponse?.results, aggregateResults.count > 0 {
                GroupBox("\(stock.ticker) - 1D") {
                    ChartView(aggregates: aggregateResults)
                }
                .frame(minHeight: 320)
                .padding()
                .backgroundStyle(Color.scoutGrey)
                .foregroundStyle(.scoutOrange)
                .font(.headline)
            } else {
                chartErrorView()
            }
            if let previousClose = stock.previousClose {
                VStack {
                    HStack {
                        infoTile("\(previousClose.openPrice)", heading: "Open")
                        infoTile("\(previousClose.closePrice)", heading: "Close")
                    }
                    HStack {
                        infoTile("\(previousClose.volume)", heading: "Volume")
                        if let marketCap = stock.tickerDetails?.marketCap {
                            infoTile("\(marketCap)", heading: "Market Cap")
                        } else {
                            infoTile("N/a", heading: "Market Cap")
                        }
                    }
                }
                .padding()
            }
            
            Spacer()
        }
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationTitle("Stock detail")
        .task {
            self.aggregatesResponse =  try? await dataManager.fetchStockAggregates(stock)
            dataManager.updateStockDetails(stock)
        }
    }
    
    func infoTile(_ text: String, heading: String? = nil) -> some View {
        GroupBox {
            HStack {
                VStack(alignment: .leading) {
                    if let heading {
                        Text(heading)
                            .bold()
                    }
                    Text(text)
                }
                Spacer()
            }
        }
        .font(.subheadline)
        .backgroundStyle(Color.scoutLightGrey)
    }
    
    func chartErrorView() -> some View {
        GroupBox {
            HStack {
                Spacer()
                VStack(alignment: .center) {
                    Spacer()
                    Text("Error loading cart")
                        .bold()
                    Spacer()
                }
                Spacer()
            }
        }
        .frame(minHeight: 320)
        .padding()
        .backgroundStyle(Color.scoutGrey)
        .foregroundStyle(.white)
        .font(.headline)
    }
}
