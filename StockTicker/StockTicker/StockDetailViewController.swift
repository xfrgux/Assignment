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
    let cellNames: [StockDetailCellName] = [.symbol, .name, .currentPrice, .lowestPrice, .highestPrice]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        stock = Stock(symbol: "PEGA", name: "Pegasystems Inc", currentPrice: 133.33, lowestPrice: 130.00, highestPrice: 140.00)
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
        content.secondaryText = getTextValueByCellNames(cellName)
        cell.contentConfiguration = content

        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Helper
    enum StockDetailCellName: String {
        case symbol = "Symbol"
        case name = "Name"
        case currentPrice = "Current Price"
        case lowestPrice = "Daily Low"
        case highestPrice = "Daily High"
    }
    
    private func getTextValueByCellNames(_ cellName: StockDetailCellName) -> String {
        guard let stock = stock else { return "" }
        switch cellName {
        case .symbol:
            return stock.symbol
        case .name:
            return stock.name
        case .currentPrice:
            return String(format:"$%.2f", stock.currentPrice)
        case .lowestPrice:
            return String(format:"$%.2f", stock.lowestPrice)
        case .highestPrice:
            return String(format:"$%.2f", stock.highestPrice)
        }
    }

}
