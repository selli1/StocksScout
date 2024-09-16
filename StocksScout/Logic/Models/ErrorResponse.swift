//
//  ErrorResponse.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/14/24.
//

import Foundation

struct ErrorResponse: Decodable {
    let status: String
    let requestID: String
    let error: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case requestID = "request_id"
        case error
    }
}
