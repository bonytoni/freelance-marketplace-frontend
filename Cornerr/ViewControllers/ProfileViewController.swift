//
//  ProfileViewController.swift
//  Cornerr
//
//  Created by Tony Chen on 4/30/22.
//

import UIKit

class ProfileViewController: UIViewController {

    private var profilePic = UIImageView()
    private var nameLabel = UILabel()
    private var editProfile = UIButton()
    private var bio = UITextView()
    private var addService = UIView(frame: CGRect(x: 162, y: 660, width: 66, height: 66))
        
    // TableView for services
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "@netid"
        view.backgroundColor = .white
        
        [profilePic, nameLabel, editProfile, bio, addService].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subView)
        }
        
        setUpUIComponents()
        setUpConstraints()
        
    }
    
    func setUpUIComponents() {
        // test image
        profilePic.image = UIImage(named: "kirby")
        profilePic.layer.cornerRadius = 60
        profilePic.layer.masksToBounds = true
        profilePic.contentMode = .scaleAspectFill
        profilePic.clipsToBounds = true
        
        let nameLabelAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]
        nameLabel.attributedText = NSAttributedString(string: "name", attributes: nameLabelAttributes)
        nameLabel.textColor = .black
        
        let editProfileAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
        // hardcoded button border width using spaces in Title
        editProfile.setAttributedTitle(NSAttributedString(string: "     Edit Profile     ", attributes: editProfileAttributes), for: .normal)
        editProfile.setTitleColor(.theme, for: .normal)
        editProfile.layer.borderColor = .theme
        editProfile.layer.borderWidth = 2
        editProfile.layer.cornerRadius = 14
        editProfile.addTarget(self, action: #selector(editProfilePressed), for: .touchUpInside)
        
        // default bio text
        bio.text = "Bio. Lorem ipsum dolor sit amet, consectetur adipiscing elit"
        bio.textColor = .black
        bio.font = .systemFont(ofSize: 14, weight: .regular)
        bio.textAlignment = .center
        
        addService.layer.cornerRadius = 33
        addService.layer.masksToBounds = true
        addService.backgroundColor = .theme
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            profilePic.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profilePic.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePic.widthAnchor.constraint(equalToConstant: 120),
            profilePic.heightAnchor.constraint(equalToConstant: 120),
            
            nameLabel.topAnchor.constraint(equalTo: profilePic.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            editProfile.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            editProfile.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bio.topAnchor.constraint(equalTo: editProfile.bottomAnchor, constant: 17),
            bio.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            bio.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            bio.heightAnchor.constraint(equalToConstant: 75),
            
        ])
    }
    
    @objc func editProfilePressed() {
        
    }

}
