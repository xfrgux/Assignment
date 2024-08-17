//
//  StockListCell.swift
//  StockTicker
//
//  Created by Frank Gu on 2024-08-15.
//

import UIKit

class StockListCell: UITableViewCell {
    
    static let identifier = "StockListCell"
    
    private let bgView: UIView = {
        let bgView = UIView()
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.layer.cornerRadius = 10
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.backgroundColor = UIColor.systemGray6
        return bgView
    }()
    private let labelSymbol: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Symbol"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    private let labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    private let labelPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$9999.99"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.contentView.addSubview(bgView)
        bgView.addSubview(labelSymbol)
        bgView.addSubview(labelName)
        bgView.addSubview(labelPrice)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 7.5),
            bgView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -7.5),
            bgView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            bgView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            
            labelPrice.widthAnchor.constraint(equalToConstant: 90),
            labelPrice.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            labelPrice.trailingAnchor.constraint(equalTo: bgView.layoutMarginsGuide.trailingAnchor),
            
            labelSymbol.leadingAnchor.constraint(equalTo: bgView.layoutMarginsGuide.leadingAnchor),
            labelSymbol.topAnchor.constraint(equalTo: bgView.layoutMarginsGuide.topAnchor, constant: 3),
            labelSymbol.bottomAnchor.constraint(equalTo: labelName.topAnchor, constant: -2),
            labelSymbol.trailingAnchor.constraint(equalTo: labelPrice.leadingAnchor, constant: -5),
            
            labelName.leadingAnchor.constraint(equalTo: bgView.layoutMarginsGuide.leadingAnchor),
            labelName.bottomAnchor.constraint(equalTo: bgView.layoutMarginsGuide.bottomAnchor, constant: -3),
            labelName.trailingAnchor.constraint(equalTo: labelPrice.leadingAnchor, constant: -5)
        ])
    }
    
    func configureCellWith(symbol: String, name: String, price: Double) {
        labelSymbol.text = symbol
        labelName.text = name
        labelPrice.text = String(format: "$%.2f", price)
    }

}
