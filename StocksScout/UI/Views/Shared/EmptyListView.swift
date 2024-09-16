//
//  EmptyListView.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/13/24.
//

import Foundation
import SwiftUI

struct EmptyListView: View {

    init(_ title: String, message: String? = nil) {
        self.title = title
        self.message = message
    }
    
    let title: String
    let message: String?
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Text(title)
                .multilineTextAlignment(.center)
                .bold()
                .foregroundColor(.scoutGrey)
            if let message {
                Text(message)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.scoutGrey)
                    .padding(.top)
            }
            Spacer()
            Spacer()
        }
        .padding()
    }
}
