//
//  Stock.swift
//  StockTicker
//
//  Created by Frank Gu on 2024-08-15.
//

import Foundation

struct Stock {
    let symbol: String
    let name: String
    let price: Double
    let low: Double
    let high: Double
}

struct StockForDecoder: Decodable {
    let name: String
    let price: Double
    let low: Double
    let high: Double
}
