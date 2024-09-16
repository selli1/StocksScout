//
//  StocksScoutApp.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/10/24.
//

import SwiftUI
import SwiftData

@main
struct StocksScoutApp: App {
    @State private var apiDataManager: APIDataManager = APIDataManager()
    @AppStorage("tickersNextUrl") var tickersNextUrl: String?

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            MyStock.self,
            TickerResult.self,
            AggregateResult.self,
            OpenCloseResponse.self,
            TickerDetailsResult.self,
            Address.self,
            Branding.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView().task {
                apiDataManager.setContext(sharedModelContainer.mainContext)
                apiDataManager.updateTickers(tickersNextUrl)
            }
            .environmentObject(apiDataManager)
        }
        .modelContainer(sharedModelContainer)
    }
    
}
