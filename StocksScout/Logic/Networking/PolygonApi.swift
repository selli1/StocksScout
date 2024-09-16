//
//  StocksNetworkProvider.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/10/24.
//

import Foundation

struct PolygonApi: StocksApiProvider {
    
    var baseURL: String = "https://api.polygon.io"
    var apiKey: String = "oqARYoi6R5JvZC8oBaaiqdX_zXt9A1ey"
    
    private let decoder = JSONDecoder()
    private let dateFormatter = DateFormatter()
    
    public func getAggregates(_ ticker: String) async throws -> AggregateResponse {
        
        let now = Date()
        var endDay = now.toMilliSeconds()
        let weekday = Calendar.current.component(.weekday, from: now)
        switch weekday {
        case 1: endDay -= TimeInterval.day
        case 2: endDay -= TimeInterval.day * 2
        default: break
        }
        let startDay = endDay - TimeInterval.day
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDayString = dateFormatter.string(from: Date(timeIntervalSince1970: startDay))
        let endDayString = dateFormatter.string(from: Date(timeIntervalSince1970: endDay))
        
        let urlString = baseURL + "/v2/aggs/ticker/\(ticker)/range/10/minute/\(startDayString)/\(endDayString)"
        guard var url = URL(string: urlString) else { throw NetworkError.urlError(urlString) }
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "adjusted", value: "true"),
            URLQueryItem(name: "sort", value: "asc"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        url.append(queryItems: queryItems)
        return try await fetchData(of: AggregateResponse.self, from: url)
    }
    
    public func getOpenClose(_ ticker: String, dateString: String) async throws -> OpenCloseResponse {
        let urlString = baseURL + "/v1/open-close/\(ticker)/\(dateString)"
        guard var url = URL(string: urlString) else { throw NetworkError.urlError(urlString) }
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "adjusted", value: "true"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        url.append(queryItems: queryItems)
        return try await fetchData(of: OpenCloseResponse.self, from: url)
    }
    
    public func getPreviousClose(_ ticker: String) async throws -> PreviousCloseResponse {
        let urlString = baseURL + "/v2/aggs/ticker/\(ticker)/prev"
        guard var url = URL(string: urlString) else { throw NetworkError.urlError(urlString) }
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "adjusted", value: "true"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        url.append(queryItems: queryItems)
        return try await fetchData(of: PreviousCloseResponse.self, from: url)
    }
    
    public func getAllTickers(_ nextURL: String?) async throws -> TickersResponse {
        let urlString = nextURL ?? baseURL + "/v3/reference/tickers/"
        guard var url = URL(string: urlString) else { throw NetworkError.urlError(urlString) }
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "market", value: "stocks"),
            URLQueryItem(name: "active", value: "true"),
            URLQueryItem(name: "order", value: "asc"),
            URLQueryItem(name: "limit", value: "1000"),
            URLQueryItem(name: "sort", value: "ticker"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        url.append(queryItems: queryItems)
        return try await fetchData(of: TickersResponse.self, from: url)
    }
    
    public func getTickerDetails(_ ticker: String) async throws -> TickerDetailsResponse {
        let urlString = baseURL + "/v3/reference/tickers/\(ticker)"
        guard var url = URL(string: urlString) else { throw NetworkError.urlError(urlString) }
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        url.append(queryItems: queryItems)
        return try await fetchData(of: TickerDetailsResponse.self, from: url)
    }
    
    private func fetchData<T: Decodable>(of type: T.Type, from url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            return try decoder.decode(type, from: data)
        } catch {

            if let apiError = try? decoder.decode(ErrorResponse.self, from: data) {
                throw NetworkError.apiError(url.absoluteString, requestId: apiError.requestID)
            } else {
                throw error
            }
        }
    }
}
