//
//  AggregateResult.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/13/24.
//

import Foundation
import SwiftData

@Model
class AggregateResult: Decodable {
    let closePrice: Double
    let highPrice: Double
    let lowPrice: Double
    let transactions: Int
    let openPrice: Double
    let timestamp: Int64
    let volume: Int
    let vwap: Double

    enum CodingKeys: String, CodingKey {
        case closePrice = "c"
        case highPrice = "h"
        case lowPrice = "l"
        case transactions = "n"
        case openPrice = "o"
        case timestamp = "t"
        case volume = "v"
        case vwap = "vw"
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.closePrice = try container.decode(Double.self, forKey: .closePrice)
        self.highPrice = try container.decode(Double.self, forKey: .highPrice)
        self.lowPrice = try container.decode(Double.self, forKey: .lowPrice)
        self.transactions = try container.decode(Int.self, forKey: .transactions)
        self.openPrice = try container.decode(Double.self, forKey: .openPrice)
        self.timestamp = Int64(try container.decode(Int64.self, forKey: .timestamp))
        self.volume = try container.decode(Int.self, forKey: .volume)
        self.vwap = try container.decode(Double.self, forKey: .vwap)
    }
}
