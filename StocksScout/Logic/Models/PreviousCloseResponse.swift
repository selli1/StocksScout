//
//  PreviousCloseResponse.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/13/24.
//

import Foundation
import SwiftData

struct PreviousCloseResponse: Decodable {
    let adjusted: Bool
    let queryCount: Int
    let requestID: String
    let results: [AggregateResult]
    let resultsCount: Int
    let status: String
    let ticker: String

    enum CodingKeys: String, CodingKey {
        case adjusted
        case queryCount
        case requestID = "request_id"
        case results
        case resultsCount
        case status
        case ticker
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.adjusted = try container.decode(Bool.self, forKey: .adjusted)
        self.queryCount = try container.decode(Int.self, forKey: .queryCount)
        self.requestID = try container.decode(String.self, forKey: .requestID)
        self.results = try container.decode([AggregateResult].self, forKey: .results)
        self.resultsCount = try container.decode(Int.self, forKey: .resultsCount)
        self.status = try container.decode(String.self, forKey: .status)
        self.ticker = try container.decode(String.self, forKey: .ticker)
    }
}
