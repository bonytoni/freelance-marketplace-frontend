//
//  ListingCell.swift
//  Cornerr
//
//  Created by Tony Chen on 4/30/22.
//

import UIKit

class ListingCell: UICollectionViewCell {
    
    static let id = "ListingCellId"
    
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var userLabel = UILabel()
    var priceLabel = UILabel()
    var avalibilityLabel = UILabel()
    var locationLabel = UILabel()
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        layer.borderColor = UIColor.darkGray.cgColor
        
        [titleLabel, descriptionLabel, userLabel, priceLabel, avalibilityLabel, locationLabel].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(subView)
        }
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
        
        ])
    }
    
    func configure(listing: Listing) {
        titleLabel.text = listing.title
        descriptionLabel.text = listing.description
        userLabel.text = String(listing.id)
        priceLabel.text = "$\(listing.price)"
        avalibilityLabel.text = listing.availability
        locationLabel.text = listing.location
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

