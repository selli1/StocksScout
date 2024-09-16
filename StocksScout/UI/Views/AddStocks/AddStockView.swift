//
//  AddStockView.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/10/24.
//

/*
 Add Stock Screen
 Present this screen modally, with a search bar at the top.
 Implement an autocomplete search feature by querying the Polygon Stocks API for stock symbols and names as the user types, ensuring the search results are displayed in a basic list format.
 Focus on functionality over design for displaying a list of stocks according to the current search query, ensuring efficient API use.
 */

import SwiftUI
import SwiftData

struct AddStockView: View {
    
    @AppStorage("lastTickerUpdate") private var lastTickerUpdate: Double?
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) private var presentationMode
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            Group {
                if searchText.count > 0 {
                    AddStockViewList(searchText, onSelect: { tickerResult in
                        addStock(tickerResult)
                    })
                } else {
                    EmptyListView("Search to add a stock", 
                                  message: lastTickerUpdate == nil ? "Stock tickers for search are currently populating.\n\n If results are missing please check back later." : nil)
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Add a stock")
            .toolbar {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Label("Edit", systemImage: "xmark")
                }
            }
        }
        .searchable(text: $searchText)
        .autocorrectionDisabled()
    }

    private func addStock(_ tickerResult: TickerResult) {
        modelContext.insert(MyStock(tickerInfo: tickerResult))
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    AddStockView()
}

