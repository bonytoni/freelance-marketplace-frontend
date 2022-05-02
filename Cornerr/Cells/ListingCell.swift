//
//  ListingCell.swift
//  Cornerr
//
//  Created by Tony Chen on 4/30/22.
//

import UIKit

class ListingCell: UICollectionViewCell {
    
    static let id = "ListingCellId"
    
    private var label = UIView()
    
    var imageView = UIImageView()
    var titleLabel = UILabel()
    var userLabel = UILabel()
    var priceLabel = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setUpComponents()
        
        [titleLabel, userLabel, priceLabel].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            label.addSubview(subView)
        }
        
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpComponents() {
        
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
        contentView.contentMode = .scaleAspectFill
        contentView.backgroundColor = .clear
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(named: "upload image")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 12)
        
        userLabel.textColor = .darkGray
        userLabel.font = .systemFont(ofSize: 10)
        
        priceLabel.textColor = .black
        priceLabel.font = .systemFont(ofSize: 12)
        
        label.layer.cornerRadius = 15
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 160)

        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: label.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: 4)
        ])
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            userLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: 4)
        ])
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 4),
            priceLabel.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: -4)
        ])
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 80),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func configure(for listing: Listing) {
        titleLabel.text = listing.title
        userLabel.text = "@" + String(listing.id)
        priceLabel.text = "$\(listing.price)"
    }
    
}

