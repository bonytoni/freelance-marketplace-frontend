//
//  PurchaseCell.swift
//  Cornerr
//
//  Created by Tony Chen on 5/6/22.
//

import UIKit

class PurchaseCell: UITableViewCell {
  
    static let id: String = "PurchaseCellId"
    
    var image = UIImageView()
    var titleLabel = UILabel()
    var priceLabel = UILabel()
    var sellerLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpComponents()
        setUpConstraints()
    }
    
    func setUpComponents() {
        contentView.backgroundColor = .clear
        
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        
        priceLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        
        sellerLabel.font = .systemFont(ofSize: 16)
        sellerLabel.textColor = .systemGray
        
        [image, titleLabel, priceLabel, sellerLabel].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(subView)
        }
        contentView.layer.masksToBounds = false
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.widthAnchor.constraint(equalToConstant: 44),
            image.heightAnchor.constraint(equalToConstant: 44),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 15),
            
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            sellerLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            sellerLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
        ])
    }
    
    func configure(for purchase: SimpleListing) {
        titleLabel.text = purchase.title
        priceLabel.text = "$\(purchase.price)"
        sellerLabel.text = "@\(purchase.seller)"
        image.image = UIImage(named: purchase.category)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
