//
//  TickerDetailsResult.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/13/24.
//

import Foundation
import SwiftData

@Model
class TickerDetailsResult: Decodable {
    let ticker: String
    let name: String
    let market: String
    let locale: String
    let primaryExchange: String
    let type: String
    let active: Bool
    let currencyName: String
    let cik: String
    let compositeFigi: String
    let shareClassFigi: String
    let marketCap: Int64?
    let phoneNumber: String?
    let address: Address?
    let companyDescription: String?
    let sicCode: String?
    let sicDescription: String?
    let tickerRoot: String
    let homepageURL: String?
    let totalEmployees: Int?
    let listDate: String?
    let branding: Branding?
    let shareClassSharesOutstanding: Int64
    let weightedSharesOutstanding: Int64?
    let roundLot: Int

    enum CodingKeys: String, CodingKey {
        case ticker
        case name
        case market
        case locale
        case primaryExchange = "primary_exchange"
        case type
        case active
        case currencyName = "currency_name"
        case cik
        case compositeFigi = "composite_figi"
        case shareClassFigi = "share_class_figi"
        case marketCap = "market_cap"
        case phoneNumber = "phone_number"
        case address
        case companyDescription = "description"
        case sicCode = "sic_code"
        case sicDescription = "sic_description"
        case tickerRoot = "ticker_root"
        case homepageURL = "homepage_url"
        case totalEmployees = "total_employees"
        case listDate = "list_date"
        case branding
        case shareClassSharesOutstanding = "share_class_shares_outstanding"
        case weightedSharesOutstanding = "weighted_shares_outstanding"
        case roundLot = "round_lot"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        ticker = try container.decode(String.self, forKey: .ticker)
        name = try container.decode(String.self, forKey: .name)
        market = try container.decode(String.self, forKey: .market)
        locale = try container.decode(String.self, forKey: .locale)
        primaryExchange = try container.decode(String.self, forKey: .primaryExchange)
        type = try container.decode(String.self, forKey: .type)
        active = try container.decode(Bool.self, forKey: .active)
        currencyName = try container.decode(String.self, forKey: .currencyName)
        cik = try container.decode(String.self, forKey: .cik)
        compositeFigi = try container.decode(String.self, forKey: .compositeFigi)
        shareClassFigi = try container.decode(String.self, forKey: .shareClassFigi)
        marketCap = try? container.decode(Int64.self, forKey: .marketCap)
        phoneNumber = try? container.decode(String.self, forKey: .phoneNumber)
        address = try? container.decode(Address.self, forKey: .address)
        companyDescription = try? container.decode(String.self, forKey: .companyDescription)
        sicCode = try? container.decode(String.self, forKey: .sicCode)
        sicDescription = try? container.decode(String.self, forKey: .sicDescription)
        tickerRoot = try container.decode(String.self, forKey: .tickerRoot)
        homepageURL = try? container.decode(String.self, forKey: .homepageURL)
        totalEmployees = try? container.decode(Int.self, forKey: .totalEmployees)
        listDate = try? container.decode(String.self, forKey: .listDate)
        branding = try? container.decode(Branding.self, forKey: .branding)
        shareClassSharesOutstanding = try container.decode(Int64.self, forKey: .shareClassSharesOutstanding)
        weightedSharesOutstanding = try? container.decode(Int64.self, forKey: .weightedSharesOutstanding)
        roundLot = try container.decode(Int.self, forKey: .roundLot)
    }
}
