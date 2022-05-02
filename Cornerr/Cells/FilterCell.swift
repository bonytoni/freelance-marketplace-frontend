//
//  FilterCell.swift
//  Cornerr
//
//  Created by Jennifer Gu on 5/1/22.
//

import Foundation
import UIKit

class FilterCell: UICollectionViewCell {
    
    private var label = UILabel()
    private var didSelect = false
    
    override init(frame: CGRect) {
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
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = .lightBlue
        
        label.textColor = .lightBlue
        label.font = .boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(for filter: Filter) {
        label.text = filter.name
        didSelect = filter.isSelected
        if didSelect {
            contentView.layer.backgroundColor = .lightBlue
            label.textColor = .white
        }
        else {
            contentView.backgroundColor = .white
            label.textColor = .lightBlue
        }
        label.sizeToFit()
    }
    
}
