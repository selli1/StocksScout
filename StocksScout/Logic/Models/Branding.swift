//
//  Branding.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/14/24.
//

import Foundation
import SwiftData

@Model
class Branding: Decodable {
    let logoURL: String
    let iconURL: String

    enum CodingKeys: String, CodingKey {
        case logoURL = "logo_url"
        case iconURL = "icon_url"
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        logoURL = try container.decode(String.self, forKey: .logoURL)
        iconURL = try container.decode(String.self, forKey: .iconURL)
    }
}
