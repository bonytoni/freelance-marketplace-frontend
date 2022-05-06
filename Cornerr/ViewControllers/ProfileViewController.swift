//
//  ProfileViewController.swift
//  Cornerr
//
//  Created by Tony Chen on 4/30/22.
//

import UIKit

class ProfileViewController: UIViewController, ListingContainer {
    
    private var currentUser: User
    private var currentToken: String

    var defaultpfpInt = Int.random(in: 1...4)
    
    var headerLabel = UILabel()
    var profilePic = UIImageView()
    var nameLabel = UILabel()
    var editProfile = UIButton()
    var bio = UITextView()
    var addService = UIImageView()
    
    var servicesLabel = UILabel()
    var servicesTableView = UITableView()
    var noServicesImageView = UIImageView()
    var noServicesTextView = UITextView()
    var services: [SimpleListing] = [] {
        didSet {
            servicesTableView.reloadData()
            noServicesImageView.isHidden = services.count != 0
            noServicesTextView.isHidden = services.count != 0
        }
    }
    
    init(user: User, token: String) {
        self.currentUser = user
        self.currentToken = token
        for ls in user.seller_listings {
            self.services.append(ls)
        }
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        [headerLabel, profilePic, nameLabel, editProfile, bio, servicesLabel, addService].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subView)
        }
        
        servicesTableView = UITableView(frame: .zero)
        servicesTableView.backgroundColor = .clear
        servicesTableView.translatesAutoresizingMaskIntoConstraints = false
        servicesTableView.showsVerticalScrollIndicator = false
        self.servicesTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        servicesTableView.register(ServiceCell.self, forCellReuseIdentifier: ServiceCell.id)
        
        servicesTableView.delegate = self
        servicesTableView.dataSource = self
        
        view.addSubview(servicesTableView)
        
        servicesTableView.addSubview(noServicesImageView)
        servicesTableView.addSubview(noServicesTextView)
        noServicesImageView.translatesAutoresizingMaskIntoConstraints = false
        noServicesTextView.translatesAutoresizingMaskIntoConstraints = false
        
        setUpUIComponents()
        setUpConstraints()
    }
    
    func setUpUIComponents() {
        headerLabel.text = "\(currentUser.username)"
        headerLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        profilePic.layer.cornerRadius = 60
        profilePic.layer.masksToBounds = true
        profilePic.contentMode = .scaleAspectFill
        profilePic.clipsToBounds = true
        if let pfp = currentUser.pfp {
            if pfp != "" {
                profilePic.image = UIImage(data: decodeBase64String(base64String: pfp))
            }
            else {
                profilePic.image = UIImage(named: "defaultpfp\(defaultpfpInt)")
            }
        }
        else {
            profilePic.image = UIImage(named: "defaultpfp\(defaultpfpInt)")
        }
        
        let nameLabelAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]
        nameLabel.attributedText = NSAttributedString(string: "\(currentUser.name)", attributes: nameLabelAttributes)
        
        let editProfileAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
        // hardcoded button border width using spaces in Title
        editProfile.setAttributedTitle(NSAttributedString(string: "     Edit Profile     ", attributes: editProfileAttributes), for: .normal)
        editProfile.setTitleColor(.lightBlue, for: .normal)
        editProfile.layer.borderColor = .lightBlue
        editProfile.layer.borderWidth = 2
        editProfile.layer.cornerRadius = 14
        editProfile.addTarget(self, action: #selector(editProfilePressed), for: .touchUpInside)
        
        bio.text = "\(currentUser.bio)"
        bio.textColor = .black
        bio.font = .systemFont(ofSize: 14, weight: .regular)
        bio.textAlignment = .center
        bio.isUserInteractionEnabled = false
        
        servicesLabel.text = "My Services"
        servicesLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        addService.image = UIImage(named: "plus sign")
        addService.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageSelected(_:)))
        tap.numberOfTapsRequired = 1
        addService.addGestureRecognizer(tap)
        
        noServicesImageView.image = UIImage(named: "no services")
        
        noServicesTextView.text = "Looks like you don’t have any services set up."
        noServicesTextView.textColor = .lightBlue
        noServicesTextView.textAlignment = .center
        noServicesTextView.font = .systemFont(ofSize: 14, weight: .semibold)
        noServicesTextView.isUserInteractionEnabled = false
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
            
            editProfile.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            editProfile.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bio.topAnchor.constraint(equalTo: editProfile.bottomAnchor, constant: 10),
            bio.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            bio.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            bio.heightAnchor.constraint(equalToConstant: 50),
            
            servicesLabel.topAnchor.constraint(equalTo: bio.bottomAnchor, constant: 5),
            servicesLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            addService.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            addService.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            servicesTableView.topAnchor.constraint(equalTo: servicesLabel.bottomAnchor, constant: 10),
            servicesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            servicesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            servicesTableView.bottomAnchor.constraint(equalTo: addService.topAnchor, constant: -10),
            
            noServicesImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noServicesImageView.centerYAnchor.constraint(equalTo: servicesTableView.centerYAnchor),
            
            noServicesTextView.topAnchor.constraint(equalTo: noServicesImageView.bottomAnchor, constant: 10),
            noServicesTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noServicesTextView.widthAnchor.constraint(equalToConstant: 200),
            noServicesTextView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
//    func changeProfile(_ str: [String]) {
//        nameLabel.text = str[0]
//        bio.text = str[1]
//    }
    
    func decodeBase64String(base64String: String) -> Data {
        let newImageData = Data(base64Encoded: base64String)
        return newImageData!
    }
    
    @objc func editProfilePressed() {
        let vc = EditProfileViewController(user: currentUser, token: currentToken)
        vc.hidesBottomBarWhenPushed = true
        vc.delegate = self
        vc.parentController = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func imageSelected(_ sender: UITapGestureRecognizer) {
        let vc = AddServiceViewController(user: self.currentUser, token: self.currentToken)
        present(vc, animated: true, completion: nil)
    }

}

extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editServiceViewController = EditServiceViewController(user: self.currentUser, token: self.currentToken)
        editServiceViewController.delegate = self
        editServiceViewController.originalService = services[indexPath.item]
        editServiceViewController.updateIndexPath(index: indexPath.row)
        present(editServiceViewController, animated: true, completion: nil)
    }

}

extension ProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServiceCell.id, for: indexPath) as! ServiceCell
        cell.configure(for: services[indexPath.item])
        return cell
    }

}

extension ProfileViewController: EditProfileViewControllerDelegate {
    
    func retrieveData(_ str: [String]) {
//        changeProfile(str)
    }
    
}
