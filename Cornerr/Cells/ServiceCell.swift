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
    
    var cellView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpUIComponents()
        setUpConstraints()
    }
    
    func setUpUIComponents() {
        contentView.backgroundColor = .clear
        
        cellView.layer.cornerRadius = 15
        cellView.backgroundColor = .white
        cellView.clipsToBounds = true
        
        image.image = UIImage(named: "kirby")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        descriptionTextView.font = .systemFont(ofSize: 10, weight: .regular)
        descriptionTextView.textAlignment = .left
        descriptionTextView.isEditable = false
        descriptionTextView.isScrollEnabled = false
        
        priceLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        contentView.layer.shadowColor = .lightBlue
        contentView.layer.shadowOffset = CGSize(width: 2, height: 4)
        contentView.layer.shadowRadius = 3.0
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = false
        
        [image, titleLabel, descriptionTextView, priceLabel].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            cellView.addSubview(subView)
        }
        
        cellView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cellView)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: cellView.topAnchor),
            image.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 84)
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 15),
            titleLabel.widthAnchor.constraint(equalToConstant: 160)
        ])
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionTextView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            descriptionTextView.widthAnchor.constraint(equalToConstant: 220),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 35)
        ])
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            priceLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -15),
            priceLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
    
    func configure(for service: SimpleListing) {
        titleLabel.text = service.title
        descriptionTextView.text = service.description
        priceLabel.text = "$\(service.price)"
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
