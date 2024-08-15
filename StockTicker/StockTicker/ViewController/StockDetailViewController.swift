//
//  StockDetailViewController.swift
//  StockTicker
//
//  Created by Frank Gu on 2024-08-15.
//

import UIKit

class StockDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var stock: Stock?
    private var stockObserver: Any?
    private let cellNames: [StockPropertyName] = [.symbol, .name, .currentPrice, .lowestPrice, .highestPrice]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockObserver = NotificationCenter.default.addObserver(forName: .stocksDidUpdate, object: nil, queue: .main) { [weak self] _ in
            if let stock = self?.stock {
                for st in StockManager.shared.stocks {
                    if st.symbol == stock.symbol {
                        self?.stock = st
                        break
                    }
                }
            }
            self?.tableView.reloadData()
        }
    }
    
    deinit {
        if let stockObserver = stockObserver {
            NotificationCenter.default.removeObserver(stockObserver)
        }
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNames.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockDetailCell", for: indexPath)

        // Configure the cell...
        let cellName = cellNames[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = cellName.rawValue
        content.secondaryText = getTextValueByPropertyNames(cellName, stock: stock)
        cell.contentConfiguration = content

        return cell
    }
    
    // MARK: - Helper
    enum StockPropertyName: String {
        case symbol = "Symbol"
        case name = "Name"
        case currentPrice = "Current Price"
        case lowestPrice = "Daily Low"
        case highestPrice = "Daily High"
    }

    func getTextValueByPropertyNames(_ perpertyName: StockPropertyName, stock: Stock?) -> String {
        guard let stock = stock else { return "" }
        switch perpertyName {
        case .symbol:
            return stock.symbol
        case .name:
            return stock.name
        case .currentPrice:
            return String(format:"$%.2f", stock.price)
        case .lowestPrice:
            return String(format:"$%.2f", stock.low)
        case .highestPrice:
            return String(format:"$%.2f", stock.high)
        }
    }
}
