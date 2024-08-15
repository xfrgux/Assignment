//
//  StockListCell.swift
//  StockTicker
//
//  Created by Frank Gu on 2024-08-15.
//

import UIKit

class StockListCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var labelSymbol: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.cornerRadius = 10
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.backgroundColor = UIColor.systemGray6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
