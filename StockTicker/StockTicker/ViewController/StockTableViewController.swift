//
//  StockTableViewController.swift
//  StockTicker
//
//  Created by Frank Gu on 2024-08-15.
//

import UIKit

class StockTableViewController: UITableViewController {
    
//    private let stocks = [
//        Stock(symbol: "PEGA", name: "Pegasystems Inc.", price: 133.2, low: 130.00, high: 140.00),
//        Stock(symbol: "MSFT", name: "Microsoft Corporation", price: 1298.26, low: 295.00, high: 301.00),
//        Stock(symbol: "FB", name: "Facebook Inc.", price: 213.6, low: 167, high: 269),
//        Stock(symbol: "AAPL", name: "Apple Inc.", price: 111.07, low: 110, high: 118),
//        Stock(symbol: "TSLA", name: "Tesla Inc.", price: 370.92, low: 210, high: 430),
//    ]
    private var stockObserver: Any?
    private var stocks = [Stock]()

    override func viewDidLoad() {
        super.viewDidLoad()
        stockObserver = NotificationCenter.default.addObserver(forName: .stocksDidUpdate, object: nil, queue: .main) { [weak self] _ in
            self?.stocks = StockManager.shared.stocks
            self?.tableView.reloadData()
        }
    }
    
    deinit {
        if let stockObserver = stockObserver {
            NotificationCenter.default.removeObserver(stockObserver)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockListCell", for: indexPath) as! StockListCell

        // Configure the cell...
        let stock = stocks[indexPath.row]
        cell.labelSymbol.text = stock.symbol
        cell.labelName.text = stock.name
        cell.labelPrice.text = String(format: "$%.2f", stock.price)

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedStock = stocks[indexPath.row]
        let destinationVC = StockDetailViewController()
        destinationVC.stock = selectedStock
        navigationController?.pushViewController(destinationVC, animated: true)
    }

}
