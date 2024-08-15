//
//  StockTableViewController.swift
//  StockTicker
//
//  Created by Frank Gu on 2024-08-15.
//

import UIKit

class StockTableViewController: UITableViewController {
    
    private let stocks = [
        Stock(symbol: "PEGA", name: "Pegasystems Inc.", currentPrice: 133.2, lowestPrice: 130.00, highestPrice: 140.00),
        Stock(symbol: "MSFT", name: "Microsoft Corporation", currentPrice: 1298.26, lowestPrice: 295.00, highestPrice: 301.00),
        Stock(symbol: "FB", name: "Facebook Inc.", currentPrice: 213.6, lowestPrice: 167, highestPrice: 269),
        Stock(symbol: "AAPL", name: "Apple Inc.", currentPrice: 111.07, lowestPrice: 110, highestPrice: 118),
        Stock(symbol: "TSLA", name: "Tesla Inc.", currentPrice: 370.92, lowestPrice: 210, highestPrice: 430),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.labelPrice.text = String(format: "$%.2f", stock.currentPrice)

        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowStockDetail" {
            guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else { return }
            let selectedStock = stocks[indexPath.row]
            if let destinationVC = segue.destination as? StockDetailViewController {
                destinationVC.stock = selectedStock
            }
        }
    }
    

}
