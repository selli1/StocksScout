//
//  StocksAPIProvider.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/13/24.
//

import Foundation

protocol StocksApiProvider {
    func getAggregates(_ ticker: String) async throws -> AggregateResponse
    func getOpenClose(_ ticker: String, dateString: String) async throws -> OpenCloseResponse
    func getPreviousClose(_ ticker: String) async throws -> PreviousCloseResponse
    func getAllTickers(_ nextURL: String?) async throws -> TickersResponse
    func getTickerDetails(_ ticker: String) async throws -> TickerDetailsResponse
}
