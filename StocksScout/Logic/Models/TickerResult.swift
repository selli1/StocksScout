//
//  TickerResult.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/13/24.
//

import Foundation
import SwiftData

@Model
class TickerResult: Decodable, Identifiable {
    let active: Bool
    let cik: String?
    let compositeFigi: String?
    let currencyName: String
    let lastUpdatedUTC: String
    let locale: String
    let market: String
    let name: String
    let primaryExchange: String
    let shareClassFigi: String?
    @Attribute(.unique) let ticker: String
    let type: String?

    enum CodingKeys: String, CodingKey {
        case active
        case cik
        case compositeFigi = "composite_figi"
        case currencyName = "currency_name"
        case lastUpdatedUTC = "last_updated_utc"
        case locale
        case market
        case name
        case primaryExchange = "primary_exchange"
        case shareClassFigi = "share_class_figi"
        case ticker
        case type
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.active = try values.decode(Bool.self, forKey: .active)
        self.cik = try? values.decode(String.self, forKey: .cik)
        self.compositeFigi = try? values.decode(String.self, forKey: .compositeFigi)
        self.currencyName = try values.decode(String.self, forKey: .currencyName)
        self.lastUpdatedUTC = try values.decode(String.self, forKey: .lastUpdatedUTC)
        self.locale = try values.decode(String.self, forKey: .locale)
        self.market = try values.decode(String.self, forKey: .market)
        self.name = try values.decode(String.self, forKey: .name)
        self.primaryExchange = try values.decode(String.self, forKey: .primaryExchange)
        self.shareClassFigi = try? values.decode(String.self, forKey: .shareClassFigi)
        self.ticker = try values.decode(String.self, forKey: .ticker)
        self.type = try? values.decode(String.self, forKey: .type)
    }
}
