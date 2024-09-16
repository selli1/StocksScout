//
//  APIDataManager.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/13/24.
//

import Foundation
import SwiftData


final class APIDataManager: ObservableObject {
    
    @Published public var hasApiError: Bool = false

    private let api: StocksApiProvider
    private var context: ModelContext?
        
    init(api: StocksApiProvider = PolygonApi()) {
        self.api = api
    }
    public func setContext(_ context: ModelContext) {
        self.context = context
    }
    
    public func updateTickers(_ nextURL: String? = nil) {
        // Return if we have updated within the past week
        if let lastTickerUpdate = UserDefaults.standard.object(forKey: "lastTickerUpdate") as? Double,
            Date(timeIntervalSince1970: lastTickerUpdate).distance(to: Date()) < TimeInterval.week {
            return
        }        
        Task {
            do {
                let tickersResponse = try await self.api.getAllTickers(nextURL)
                tickersResponse.results.forEach { tickerResponse in
                    DispatchQueue.main.async {
                        self.context?.insert(tickerResponse)
                    }
                }
                if let urlString = tickersResponse.nextURL {
                    UserDefaults.standard.setValue(nextURL, forKey: "tickersNextUrl")
                    updateTickers(urlString)
                } else {
                    UserDefaults.standard.setValue(nil, forKey: "tickersNextUrl")
                    UserDefaults.standard.setValue(Date().timeIntervalSince1970, forKey: "lastTickerUpdate")
                }
            } catch NetworkError.apiError(let urlString, let requestId) {
                print("APIERROR: \(urlString) \(requestId)")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    public func updateStockData(_ stock: MyStock) {
        Task {
            do {
                let previousCloseResponse = try await self.api.getPreviousClose(stock.tickerInfo.ticker)
                DispatchQueue.main.async {
                    stock.previousClose = previousCloseResponse.results.first
                }
            } catch NetworkError.apiError(_, _) {
                DispatchQueue.main.async { [weak self] in
                    self?.hasApiError = true
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
        
    public func fetchStockAggregates(_ stock: MyStock) async throws -> AggregateResponse {
        do {
            return try await self.api.getAggregates(stock.tickerInfo.ticker)
        } catch NetworkError.apiError(let urlString, let requestId) {
            DispatchQueue.main.async { [weak self] in
                self?.hasApiError = true
            }
            throw NetworkError.apiError(urlString, requestId: requestId)
        } catch {
            throw error
        }
    }
    
    public func updateStockDetails(_ stock: MyStock) {
        Task {
            do {
                let tickerDetailsResponse = try await self.api.getTickerDetails(stock.tickerInfo.ticker)
                DispatchQueue.main.async {
                    stock.tickerDetails = tickerDetailsResponse.results
                }
            } catch NetworkError.apiError(_, _) {
                DispatchQueue.main.async { [weak self] in
                    self?.hasApiError = true
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
