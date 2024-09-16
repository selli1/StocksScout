//
//  NetworkError.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/10/24.
//

import Foundation

enum NetworkError: Error {
    case filePathError(_ fileName: String)
    case urlError(_ url: String)
    case apiError(_ url: String, requestId: String)
}
