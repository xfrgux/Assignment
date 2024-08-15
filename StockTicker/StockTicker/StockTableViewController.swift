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
    var stocks = [Stock]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStockQuotes()
    }
    
    func fetchStockQuotes() {
        NetworkManager.shared.fetchStockQuotes { [weak self] stocks in
            guard let stocks = stocks else { return }
            self?.stocks = stocks
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
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
