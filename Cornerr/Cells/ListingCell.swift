//
//  ListingCell.swift
//  Cornerr
//
//  Created by Tony Chen on 4/30/22.
//

import UIKit

class ListingCell: UICollectionViewCell {
        
    var imageView = UIImageView()
    var label = UIView()
    var titleLabel = UILabel()
    var userLabel = UILabel()
    var priceLabel = UILabel()
    var categoryLabel = UILabel()
    
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
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = .boldSystemFont(ofSize: 12)
        
        userLabel.textColor = .darkGray
        userLabel.font = .systemFont(ofSize: 10)
        
        priceLabel.font = .boldSystemFont(ofSize: 12)
        
        categoryLabel.font = .systemFont(ofSize: 10)
        categoryLabel.layer.cornerRadius = 10
        categoryLabel.clipsToBounds = true
        categoryLabel.textAlignment = .center
        
        label.layer.masksToBounds = true
        label.clipsToBounds = false
        label.layer.cornerRadius = 15
        label.backgroundColor = .white
        label.layer.borderColor = UIColor.white.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, userLabel, priceLabel, categoryLabel].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            label.addSubview(subView)
        }
        
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -60),
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
            titleLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: 16),
            titleLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            userLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: 16)
        ])
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: label.topAnchor, constant: 12),
            priceLabel.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            categoryLabel.heightAnchor.constraint(equalToConstant: 20),
            categoryLabel.widthAnchor.constraint(equalToConstant: 50),
            categoryLabel.trailingAnchor.constraint(equalTo: label.trailingAnchor,constant: -16),
            categoryLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8)
        ])
    }
    
    func configure(for listing: Listing) {
        titleLabel.text = listing.title
        userLabel.text = "@" + listing.seller.username
        priceLabel.text = "$\(listing.price)"
        categoryLabel.text = listing.category
        imageView.image = UIImage(data: decodeBase64String(base64String: listing.picture))
        setCategoryLabelColor(for: listing.category)
    }
    
    func decodeBase64String(base64String: String) -> Data {
        let newImageData = Data(base64Encoded: base64String)
        return newImageData!
    }
    
    func setCategoryLabelColor(for name: String) {
        var hexCode: String = "#F5F5F5"
        
        switch name {
        case "Beauty" :
            hexCode = "#FFE3E1"
        case "Fashion":
            hexCode = "#DFF9BF"
        case "Media":
            hexCode = "#FFC896"
        case "Tech":
            hexCode = "#BDE3FF"
        case "Crafts":
            hexCode = "#F2E7FF"
        case "Food":
            hexCode = "#FFE8A3"
        default:
            hexCode = "#F5F5F5"
        }
        
        categoryLabel.backgroundColor = UIColor(hexString: hexCode)
        categoryLabel.layer.borderColor = UIColor.clear.cgColor
    }
    
}
