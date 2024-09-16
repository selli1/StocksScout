//
//  EmptyListView.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/13/24.
//

import Foundation
import SwiftUI

struct EmptyListView: View {
    
    init(_ message: String) {
        self.message = message
    }
    
    let message: String
    
    var body: some View {
        VStack{
            Spacer()
            Text("Your stock list is empty")
                .bold()
                .foregroundColor(.scoutGrey)
            Spacer()
            Spacer()
        }
    }
}
