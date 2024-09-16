//
//  OpenCloseResponse.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/13/24.
//

import Foundation
import SwiftData

@Model
class OpenCloseResponse: Decodable {
    let afterHours: Double
    let close: Double
    let from: String
    let high: Double
    let low: Double
    let open: Double
    let preMarket: Double
    let status: String
    let symbol: String
    let volume: Int
    
    enum CodingKeys: CodingKey {
        case afterHours
        case close
        case from
        case high
        case low
        case open
        case preMarket
        case status
        case symbol
        case volume
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.afterHours = try container.decode(Double.self, forKey: .afterHours)
        self.close = try container.decode(Double.self, forKey: .close)
        self.from = try container.decode(String.self, forKey: .from)
        self.high = try container.decode(Double.self, forKey: .high)
        self.low = try container.decode(Double.self, forKey: .low)
        self.open = try container.decode(Double.self, forKey: .open)
        self.preMarket = try container.decode(Double.self, forKey: .preMarket)
        self.status = try container.decode(String.self, forKey: .status)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.volume = try container.decode(Int.self, forKey: .volume)
    }
}
