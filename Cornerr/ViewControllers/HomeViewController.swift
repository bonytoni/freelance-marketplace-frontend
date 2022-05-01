//
//  ViewController.swift
//  Cornerr
//
//  Created by Tony Chen on 4/30/22.
//

import UIKit

class HomeViewController: UIViewController {

    let appNameImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        [appNameImageView].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subView)
        }
        
        setUpUIComponents()
        setUpConstraints()
    }
    
    func setUpUIComponents() {
        appNameImageView.image = UIImage(named: "freelance")
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            appNameImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            appNameImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            
        ])
    }

}

