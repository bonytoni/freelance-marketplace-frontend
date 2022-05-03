//
//  ServiceCell.swift
//  Cornerr
//
//  Created by Tony Chen on 5/1/22.
//

import UIKit

class ServiceCell: UITableViewCell {
  
    static let id: String = "ServiceCellId"
    
    var image = UIImageView()
    var titleLabel = UILabel()
    var descriptionTextView = UITextView()
    var priceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [image, titleLabel, descriptionTextView, priceLabel].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(subView)
        }
        
        setUpUIComponents()
        setUpConstraints()
    }
    
    func setUpUIComponents() {
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        contentView.backgroundColor = .clear
        
        image.image = UIImage(named: "kirby")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        descriptionTextView.font = .systemFont(ofSize: 10, weight: .regular)
        descriptionTextView.textAlignment = .left
        descriptionTextView.isEditable = false
        descriptionTextView.isScrollEnabled = false
        
        priceLabel.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            image.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            image.widthAnchor.constraint(equalToConstant: 84),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 15),
            titleLabel.widthAnchor.constraint(equalToConstant: 160),
            
            descriptionTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionTextView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            descriptionTextView.widthAnchor.constraint(equalToConstant: 220),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 40),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            priceLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configure(for service: Listing) {
        titleLabel.text = service.title
        descriptionTextView.text = service.description
        priceLabel.text = "$\(service.price)"
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
