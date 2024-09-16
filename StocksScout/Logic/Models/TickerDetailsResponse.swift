//
//  TickerDetailsResponse.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/13/24.
//

import Foundation
import SwiftData

struct TickerDetailsResponse: Decodable {
    let requestID: String
    let results: TickerDetailsResult
    let status: String

    enum CodingKeys: String, CodingKey {
        case requestID = "request_id"
        case results
        case status
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.requestID = try container.decode(String.self, forKey: .requestID)
        self.results = try container.decode(TickerDetailsResult.self, forKey: .results)
        self.status = try container.decode(String.self, forKey: .status)
    }
}
