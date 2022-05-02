//
//  ListingCell.swift
//  Cornerr
//
//  Created by Tony Chen on 4/30/22.
//

import UIKit

class ListingCell: UICollectionViewCell {
    
    //static let id = "ListingCellId"
    
    var imageView = UIImageView()
    var label = UIView()
    var titleLabel = UILabel()
    var userLabel = UILabel()
    var priceLabel = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setUpComponents()
        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpComponents() {
        
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        contentView.backgroundColor = .clear
        
        imageView.image = UIImage(named: "kirby")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = .boldSystemFont(ofSize: 14)
        
        userLabel.textColor = .darkGray
        userLabel.font = .systemFont(ofSize: 12)
        
        priceLabel.font = .boldSystemFont(ofSize: 14)
        
        label.layer.masksToBounds = true
        label.clipsToBounds = false
        label.layer.cornerRadius = 15
        label.backgroundColor = .white
        label.layer.borderColor = UIColor.white.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, userLabel, priceLabel].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            label.addSubview(subView)
        }
        
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)

        ])
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -70),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: label.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: 16)
        ])
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            userLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: 16)
        ])
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: label.topAnchor, constant: 12),
            priceLabel.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(for listing: Listing) {
        titleLabel.text = listing.title
        userLabel.text = "@" + String(listing.seller.id)
        priceLabel.text = "$\(listing.price)"
    }
    
}
