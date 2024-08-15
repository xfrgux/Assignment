//
//  NetworkManager.swift
//  StockTicker
//
//  Created by Frank Gu on 2024-08-15.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let stockQuotesURL = "https://6twxtqzjyoyruhqzywfrcdxoci0sltgk.lambda-url.us-east-1.on.aws/"
    
    func fetchStockQuotes(completion: @escaping ([Stock]?) -> Void) {
        guard let url = URL(string: stockQuotesURL) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknow error")")
                completion(nil)
                return
            }
            
            do {
                let dict = try JSONDecoder().decode([String: StockForDecoder].self, from: data)
                var stocks = [Stock]()
                for (symbol, info) in dict {
                    stocks.append(Stock(symbol: symbol, name: info.name, price: info.price, low: info.low, high: info.high))
                }
                stocks.sort { $0.symbol < $1.symbol }
                completion(stocks)
            } catch {
                print("Decoding error: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
}
