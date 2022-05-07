//
//  ProfileViewController.swift
//  Cornerr
//
//  Created by Tony Chen on 4/30/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let refreshControl = UIRefreshControl()
    
    private var currentUser: User
    private var currentToken: String

    var defaultpfpInt = Int.random(in: 1...4)
    
    var headerLabel = UILabel()
    var profilePic = UIImageView()
    var nameLabel = UILabel()
    var editProfile = UIButton()
    var bio = UITextView()
    var addService = UIImageView()
    
    var servicesTableViewContainer = UIView()
    var onServicesTableImage = UIImageView()
    var goToPurchasesTableImage = UIImageView()
    var servicesLabel = UILabel()
    var servicesTableView = UITableView()
    var noServicesImageView = UIImageView()
    var noServicesTextView = UITextView()
    var services: [SimpleListing] {
        didSet {
            servicesTableView.reloadData()
            noServicesImageView.isHidden = services.count != 0
            noServicesTextView.isHidden = services.count != 0
        }
    }
    var purchases: [SimpleListing]
    
    var purchasesTableViewContainer = UIView()
    var goToServicesTableImage = UIImageView()
    var onPurchasesTableImage = UIImageView()
    var purchasesLabel = UILabel()
    var purchasesTableView = UITableView()
    
    init(user: User, token: String) {
        self.currentUser = user
        self.currentToken = token
        self.services = user.seller_listings
        // initialize !!!
        self.purchases = []
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        servicesTableViewContainer.layer.masksToBounds = true
        servicesTableViewContainer.clipsToBounds = false
        purchasesTableViewContainer.layer.masksToBounds = true
        purchasesTableViewContainer.clipsToBounds = false
        
        [headerLabel, profilePic, nameLabel, editProfile, bio, servicesTableViewContainer, purchasesTableViewContainer].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subView)
        }
        
        // services table view
        servicesTableViewContainer.addSubview(onServicesTableImage)
        onServicesTableImage.translatesAutoresizingMaskIntoConstraints = false
        servicesTableViewContainer.addSubview(goToPurchasesTableImage)
        goToPurchasesTableImage.translatesAutoresizingMaskIntoConstraints = false
        servicesTableViewContainer.addSubview(servicesLabel)
        servicesLabel.translatesAutoresizingMaskIntoConstraints = false
        servicesTableViewContainer.addSubview(addService)
        addService.translatesAutoresizingMaskIntoConstraints = false
        
        servicesTableView = UITableView(frame: .zero)
        servicesTableView.backgroundColor = .clear
        servicesTableView.translatesAutoresizingMaskIntoConstraints = false
        servicesTableView.showsVerticalScrollIndicator = false
        self.servicesTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        servicesTableView.register(ServiceCell.self, forCellReuseIdentifier: ServiceCell.id)
        
        servicesTableView.delegate = self
        servicesTableView.dataSource = self
        
        servicesTableViewContainer.addSubview(servicesTableView)
        
        checkServices(user: currentUser)
        servicesTableView.addSubview(noServicesImageView)
        servicesTableView.addSubview(noServicesTextView)
        noServicesImageView.translatesAutoresizingMaskIntoConstraints = false
        noServicesTextView.translatesAutoresizingMaskIntoConstraints = false
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        servicesTableView.addSubview(refreshControl)
        
        // purchases table view
        purchasesTableViewContainer.addSubview(onPurchasesTableImage)
        onPurchasesTableImage.translatesAutoresizingMaskIntoConstraints = false
        purchasesTableViewContainer.addSubview(goToServicesTableImage)
        goToServicesTableImage.translatesAutoresizingMaskIntoConstraints = false
        purchasesTableViewContainer.addSubview(purchasesLabel)
        purchasesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        purchasesTableView = UITableView(frame: .zero)
        purchasesTableView.backgroundColor = .clear
        purchasesTableView.translatesAutoresizingMaskIntoConstraints = false
        purchasesTableView.showsVerticalScrollIndicator = false
        self.purchasesTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        purchasesTableView.register(PurchaseCell.self, forCellReuseIdentifier: PurchaseCell.id)
        
        purchasesTableView.delegate = self
        purchasesTableView.dataSource = self
        
        purchasesTableViewContainer.addSubview(purchasesTableView)
        
        purchasesTableViewContainer.isHidden = true
        purchasesTableViewContainer.isUserInteractionEnabled = false
        
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
        
        purchasesLabel.text = "Purchase History"
        purchasesLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
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
        
        goToServicesTableImage.image = UIImage(named: "go to services")
        goToServicesTableImage.isUserInteractionEnabled = true
        let goToServicesTap = UITapGestureRecognizer(target: self, action: #selector(goToServicesTable))
        goToServicesTap.numberOfTapsRequired = 1
        goToServicesTableImage.addGestureRecognizer(goToServicesTap)
                                         
        goToPurchasesTableImage.image = UIImage(named: "go to purchases")
        goToPurchasesTableImage.isUserInteractionEnabled = true
        let goToPurchasesTap = UITapGestureRecognizer(target: self, action: #selector(goToPurchasesTable))
        goToPurchasesTap.numberOfTapsRequired = 1
        goToPurchasesTableImage.addGestureRecognizer(goToPurchasesTap)
        
        onServicesTableImage.image = UIImage(named: "on services")
        onPurchasesTableImage.image = UIImage(named: "on purchases")
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            servicesTableViewContainer.topAnchor.constraint(equalTo: view.topAnchor),
            servicesTableViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            servicesTableViewContainer.leftAnchor.constraint(equalTo: view.leftAnchor),
            servicesTableViewContainer.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            purchasesTableViewContainer.topAnchor.constraint(equalTo: view.topAnchor),
            purchasesTableViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            purchasesTableViewContainer.leftAnchor.constraint(equalTo: view.leftAnchor),
            purchasesTableViewContainer.rightAnchor.constraint(equalTo: view.rightAnchor),
            
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
            
            servicesLabel.topAnchor.constraint(equalTo: onServicesTableImage.bottomAnchor),
            servicesLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            purchasesLabel.topAnchor.constraint(equalTo: onServicesTableImage.bottomAnchor),
            purchasesLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            addService.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            addService.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            servicesTableView.topAnchor.constraint(equalTo: servicesLabel.bottomAnchor, constant: 10),
            servicesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            servicesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            servicesTableView.bottomAnchor.constraint(equalTo: addService.topAnchor, constant: -10),
            
            purchasesTableView.topAnchor.constraint(equalTo: servicesLabel.bottomAnchor, constant: 10),
            purchasesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            purchasesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            purchasesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            noServicesImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noServicesImageView.centerYAnchor.constraint(equalTo: servicesTableView.centerYAnchor),
            
            noServicesTextView.topAnchor.constraint(equalTo: noServicesImageView.bottomAnchor, constant: 10),
            noServicesTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noServicesTextView.widthAnchor.constraint(equalToConstant: 200),
            noServicesTextView.heightAnchor.constraint(equalToConstant: 50),
            
            onServicesTableImage.topAnchor.constraint(equalTo: bio.bottomAnchor),
            onServicesTableImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70),
            
            goToPurchasesTableImage.topAnchor.constraint(equalTo: bio.bottomAnchor),
            goToPurchasesTableImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70),
            
            onPurchasesTableImage.topAnchor.constraint(equalTo: bio.bottomAnchor),
            onPurchasesTableImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70),
            
            goToServicesTableImage.topAnchor.constraint(equalTo: bio.bottomAnchor),
            goToServicesTableImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70),
        ])
    }
    
    func checkServices(user: User) {
        if !user.seller_listings.isEmpty {
            noServicesTextView.isHidden = true
            noServicesImageView.isHidden = true
        }
    }
    
    func changeProfile(_ str: [String]) {
        nameLabel.text = str[0]
        bio.text = str[1]
        profilePic.image = UIImage(data: decodeBase64String(base64String: str[2]))
        currentUser = User(id: currentUser.id, username: currentUser.username, name: str[0], contact: currentUser.contact, bio: str[1], pfp: str[2], seller_ls: currentUser.seller_listings, buyer_ls: currentUser.buyers_listings)
    }
    
    func decodeBase64String(base64String: String) -> Data {
        let newImageData = Data(base64Encoded: base64String)
        return newImageData!
    }
    
    func getSellerListings(id: Int) {
        NetworkManager.getUserById(id: currentUser.id, token: currentToken, completion: { response in
            self.currentUser = response
            self.services = response.seller_listings
        })
    }
    
    @objc func goToServicesTable() {
        purchasesTableViewContainer.isHidden = true
        purchasesTableViewContainer.isUserInteractionEnabled = false
        servicesTableViewContainer.isHidden = false
        servicesTableViewContainer.isUserInteractionEnabled = true
    }
    
    @objc func goToPurchasesTable() {
        servicesTableViewContainer.isHidden = true
        servicesTableViewContainer.isUserInteractionEnabled = false
        purchasesTableViewContainer.isHidden = false
        purchasesTableViewContainer.isUserInteractionEnabled = true
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
    
    @objc private func refresh(_ sender: AnyObject) {
//        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//            self.listingView.reloadData()
//            self.refreshControl.endRefreshing()
//        }
        getSellerListings(id: currentUser.id)
        self.servicesTableView.reloadData()
        refreshControl.endRefreshing()
    }

}

extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == servicesTableView {
            return 84
        }
        if tableView == purchasesTableView {
            return 75
        }
        return 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == servicesTableView{
            let editServiceViewController = EditServiceViewController(user: self.currentUser, token: self.currentToken, originalService: services[indexPath.item])
            editServiceViewController.updateIndexPath(index: indexPath.row)
            present(editServiceViewController, animated: true, completion: nil)
        }
    }

}

extension ProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == servicesTableView {
            return services.count
        }
        if tableView == purchasesTableView {
            return purchases.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == servicesTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: ServiceCell.id, for: indexPath) as! ServiceCell
            cell.configure(for: services[indexPath.item])
            return cell
        }
        if tableView == purchasesTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: PurchaseCell.id, for: indexPath) as! PurchaseCell
            cell.configure(for: purchases[indexPath.item], category: purchases[indexPath.item].category)
            return cell
        }
        return UITableViewCell()
    }

}

extension ProfileViewController: EditProfileViewControllerDelegate {

    func retrieveData(_ str: [String]) {
        changeProfile(str)
    }

}
