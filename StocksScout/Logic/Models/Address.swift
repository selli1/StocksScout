//
//  Address.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/14/24.
//

import Foundation
import SwiftData

@Model
class Address: Decodable {
    let address1: String
    let city: String
    let state: String
    let postalCode: String

    enum CodingKeys: String, CodingKey {
        case address1
        case city
        case state
        case postalCode = "postal_code"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.address1 = try container.decode(String.self, forKey: .address1)
        self.city = try container.decode(String.self, forKey: .city)
        self.state = try container.decode(String.self, forKey: .state)
        self.postalCode = try container.decode(String.self, forKey: .postalCode)
    }
}
