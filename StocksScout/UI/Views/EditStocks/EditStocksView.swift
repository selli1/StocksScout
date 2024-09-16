//
//  EditStocksView.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/10/24.
//

/*
 List of Stocks Screen
 Show a list of stocks with names and symbols in a straightforward list view.
 Add a button in the top right corner of the screen to navigate to an “Add Stock” screen
 Show a list of stocks with names and symbols in a straightforward list view.
 Add a button in the top right corner of the screen to navigate to an “Add Stock” screen.
 Implement a swipe-to-delete feature that removes a stock from the list and clears any related data from storage, keeping the UI simple. 
 */

import SwiftUI
import SwiftData

struct EditStocksView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.modelContext) private var modelContext
    @State private var isShowingAddScreen = false
    @Query private var stocks: [MyStock]

    var body: some View {
        NavigationStack {
            Group {
                if stocks.count > 0 {
                    List() {
                        ForEach(stocks) { stock in
                            TickerRowView(ticker: stock.tickerInfo)
                            //MyStockRowView(stock: stock)
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(.plain)
                } else {
                    EmptyListView("Your stock list is empty")
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Edit my stocks")
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Label("Edit", systemImage: "xmark")
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: { isShowingAddScreen = true }) {
                        Label("Edit", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddScreen) {
                AddStockView()
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(stocks[index])
            }
        }
    }
}

#Preview {
    EditStocksView()
}
