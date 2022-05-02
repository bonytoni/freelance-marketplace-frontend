//
//  ProfileViewController.swift
//  Cornerr
//
//  Created by Tony Chen on 4/30/22.
//

import UIKit

class ProfileViewController: UIViewController, ModelContainer {

    var headerLabel = UILabel()
    var profilePic = UIImageView()
    var nameLabel = UILabel()
    var editProfile = UIButton()
    var bio = UITextView()
    var addService = UIImageView()
    
    var servicesTableView = UITableView()
    var noServicesImageView = UIImageView()
    var services: [Listing] = [] {
        didSet {
            servicesTableView.reloadData()
            noServicesImageView.isHidden = services.count != 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        [headerLabel, profilePic, nameLabel, editProfile, bio, addService, noServicesImageView].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subView)
        }
        
        servicesTableView = UITableView(frame: .zero)
        servicesTableView.translatesAutoresizingMaskIntoConstraints = false
        servicesTableView.delegate = self
        servicesTableView.dataSource = self
        servicesTableView.register(ServiceCell.self, forCellReuseIdentifier: ServiceCell.id)
        view.addSubview(servicesTableView)
        servicesTableView.separatorColor = .darkBlue
        
        setUpUIComponents()
        setUpConstraints()
    }
    
    func setUpUIComponents() {
        headerLabel.text = "@netid"
        headerLabel.textColor = .black
        headerLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
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
        editProfile.setTitleColor(.lightBlue, for: .normal)
        editProfile.layer.borderColor = .lightBlue
        editProfile.layer.borderWidth = 2
        editProfile.layer.cornerRadius = 14
        editProfile.addTarget(self, action: #selector(editProfilePressed), for: .touchUpInside)
        
        // default bio text
        bio.text = "Bio. Lorem ipsum dolor sit amet, consectetur adipiscing elit"
        bio.textColor = .black
        bio.font = .systemFont(ofSize: 14, weight: .regular)
        bio.textAlignment = .center
        
        addService.image = UIImage(named: "plus sign")
        addService.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageSelected(_:)))
        tap.numberOfTapsRequired = 1
        addService.addGestureRecognizer(tap)
        
        noServicesImageView.image = UIImage(named: "no services")
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            profilePic.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15),
            profilePic.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePic.widthAnchor.constraint(equalToConstant: 120),
            profilePic.heightAnchor.constraint(equalToConstant: 120),
            
            nameLabel.topAnchor.constraint(equalTo: profilePic.bottomAnchor, constant: 15),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            editProfile.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            editProfile.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bio.topAnchor.constraint(equalTo: editProfile.bottomAnchor, constant: 15),
            bio.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            bio.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            bio.heightAnchor.constraint(equalToConstant: 50),
            
            addService.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            addService.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            servicesTableView.topAnchor.constraint(equalTo: bio.bottomAnchor, constant: 15),
            servicesTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            servicesTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            servicesTableView.bottomAnchor.constraint(equalTo: addService.topAnchor, constant: -5),
            
            noServicesImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noServicesImageView.bottomAnchor.constraint(equalTo: addService.topAnchor, constant: -20)
        ])
    }
    
    @objc func editProfilePressed() {
        let vc = EditProfileViewController()
        vc.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func imageSelected(_ sender: UITapGestureRecognizer) {
        let vc = ServiceViewController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }

}

extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editServiceViewController = ServiceViewController()
        editServiceViewController.delegate = self
        editServiceViewController.originalService = services[indexPath.item]
        editServiceViewController.updateIndexPath(index: indexPath.row)
        present(editServiceViewController, animated: true, completion: nil)
    }

}

extension ProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        services.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServiceCell.id, for: indexPath) as! ServiceCell
        cell.configure(service: services[indexPath.item])
        return cell
    }

}
