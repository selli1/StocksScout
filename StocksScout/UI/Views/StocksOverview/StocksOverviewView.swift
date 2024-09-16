//
//  StocksOverviewView.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/10/24.
//

/*
 Stocks Overview Screen
 Display a list of stocks with a summary (current price, daily change) of each stock in a simple, easy-to-read format.
 Include a button in the top right corner of the screen to navigate to a “List of Stocks” screen.
 Open a “Detailed Stock Information” screen when tapping on a specific stock.
 Focus on presenting the essential data clearly.
 Implement a pull-to-refresh feature to update stock data
 Fetch new data every time the app starts, displaying this information in a no-frills, accessible manner.
 */

import SwiftUI
import SwiftData

struct StocksOverviewView: View {
    
    @EnvironmentObject var dataManager: APIDataManager
    
    @Query private var stocks: [MyStock]
    @State public var hasAttemptedInitialLoad: Bool = false
    @State private var isShowingEditScreen: Bool = false
    @State private var presentedStock: MyStock?

    var body: some View {
        Group {
            if stocks.count > 0 {
                List(stocks) { stock in
                    MyStockRowView(stock: stock)
                        .overlay {
                            NavigationLink(value: stock) {
                                EmptyView()
                            }
                            .opacity(0)
                        }
                }
                .listStyle(.plain)
                .refreshable {
                    refreshStockData()
                }
            } else {
                EmptyListView("Your stock list is empty")
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("My stocks")
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItemGroup(placement: .principal) {
                Image(.scoutLogo)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30.0, alignment: .center)
                    .foregroundColor(Color.scoutOrange)
            }
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button(action: { isShowingEditScreen = true }) {
                    Label("Edit", systemImage: "list.bullet")
                }
            }
        }
        .navigationDestination(for: MyStock.self) { stock in
            StockDetailView(stock: stock)
        }
        .fullScreenCover(isPresented: $isShowingEditScreen) {
            EditStocksView()
        }
        .task {
            if hasAttemptedInitialLoad == false {
                refreshStockData()
            }
        }
        .onChange(of: stocks.count) { initialValue, newValue in
            if newValue > initialValue {
                refreshStockData()
            }
        }
    }
    
    func refreshStockData() {
        stocks.forEach { stock in
            dataManager.updateStockData(stock)
        }
        hasAttemptedInitialLoad = true
    }
}

#Preview {
    StocksOverviewView()
}
