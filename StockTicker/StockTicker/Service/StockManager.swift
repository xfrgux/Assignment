//
//  NetworkManager.swift
//  StockTicker
//
//  Created by Frank Gu on 2024-08-15.
//

import Foundation

class StockManager {
    
    let stockQuotesURL = "https://6twxtqzjyoyruhqzywfrcdxoci0sltgk.lambda-url.us-east-1.on.aws/"
    
    static let shared = StockManager()
    private var timer: Timer?
    private(set) var stocks = [Stock]()
    
    func startPolling() {
        print("startPolling")
        fetchStockQuotes()
        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true, block: { [weak self] _ in
            self?.fetchStockQuotes()
        })
    }
    
    func stopPolling() {
        print("stopPolling")
        timer?.invalidate()
    }
    
    func fetchStockQuotes() {
        print("fetchStockQuotes")
        guard let url = URL(string: stockQuotesURL) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknow error")")
                return
            }
            
            do {
                let dict = try JSONDecoder().decode([String: StockForDecoder].self, from: data)
                var stocks = [Stock]()
                for (symbol, info) in dict {
                    stocks.append(Stock(symbol: symbol, name: info.name, price: info.price, low: info.low, high: info.high))
                }
                stocks.sort { $0.symbol < $1.symbol }
                self?.stocks = stocks
                NotificationCenter.default.post(name: .stocksDidUpdate, object: nil)
            } catch {
                print("Decoding error: \(error)")
            }
        }
        task.resume()
    }
}

extension Notification.Name {
    static let stocksDidUpdate = Notification.Name("stocksDidUpdate")
}
