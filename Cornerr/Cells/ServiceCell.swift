//
//  ServiceCell.swift
//  Cornerr
//
//  Created by Tony Chen on 5/1/22.
//

import UIKit

class ServiceCell: UITableViewCell {
  
    static let id: String = "ServiceCellId"
    
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var priceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [titleLabel, descriptionLabel, priceLabel].forEach { subView in
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
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black
        
        descriptionLabel.font = .systemFont(ofSize: 10, weight: .regular)
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = .black
        
        priceLabel.font = .systemFont(ofSize: 16, weight: .bold)
        priceLabel.textColor = .black
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 98),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -69),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -60),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 25),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            priceLabel.widthAnchor.constraint(equalToConstant: 30),
            priceLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configure(for service: Listing) {
        titleLabel.text = service.title
        descriptionLabel.text = service.description
        priceLabel.text = "$\(service.price)"
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
