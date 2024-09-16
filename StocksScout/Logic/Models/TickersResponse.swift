//
//  TickersResponse.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/13/24.
//

import Foundation
import SwiftData

struct TickersResponse: Decodable {
    let count: Int
    let nextURL: String?
    @Attribute(.unique) let requestID: String
    let results: [TickerResult]
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case count
        case nextURL = "next_url"
        case requestID = "request_id"
        case results
        case status
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.nextURL = try? container.decode(String.self, forKey: .nextURL)
        self.requestID = try container.decode(String.self, forKey: .requestID)
        self.results = try container.decode([TickerResult].self, forKey: .results)
        self.status = try container.decode(String.self, forKey: .status)
    }
}
