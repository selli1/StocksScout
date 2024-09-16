//
//  ContentView.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @EnvironmentObject var dataManager: APIDataManager
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.scoutGrey]
    }
    
    var body: some View {
        NavigationStack {
            StocksOverviewView()
        }
        .alert(isPresented: $dataManager.hasApiError, content: {
            Alert(title: Text("Maximum network calls exceeded"),
                  message: Text("You have exceeded the maximum number of network calls for your subscription.  Please upgrade your subscription tier or check back later"))
        })
    }
}

#Preview {
    ContentView()
}
