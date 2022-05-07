//
//  ListingViewController.swift
//  Cornerr
//
//  Created by Jennifer Gu on 5/2/22.
//

import UIKit

class ListingViewController: UIViewController {
    
    private var listing: Listing
    private var user: User
    private var token: String
    
    private var listingPic = UIImageView()
    private var infoView = UIView()
    
    private var titleLabel = UILabel()
    private var priceLabel = UILabel()
    private var contactLabel = UILabel()
    private var sellerLabel = UILabel()
    private var categoryLabel = UILabel()
    private var locationLabel = UILabel()
    private var descriptionView = UITextView()
    private var availabilityView = UITextView()
    private var purchaseButton = UIButton()
    
    init(listing: Listing, user: User, token: String) {
        self.listing = listing
        self.user = user
        self.token = token
        super.init(nibName: nil, bundle: nil)
        self.titleLabel.text = listing.title
        // init self.lisitingPic.image in setUpComponents()
        self.sellerLabel.text = "@" + listing.seller.username
        self.priceLabel.text = "$\(listing.price)"
        self.contactLabel.text = "Contact: " + listing.seller.contact
        self.categoryLabel.text = listing.category
        self.locationLabel.text = listing.location
        self.descriptionView.text = "Description: " + listing.description
        self.availabilityView.text = "Availability: " + listing.availability
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpComponents()
        
        setUpConstraints()
        
    }
    
    func setUpComponents() {
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = UIColor.white
        
        view.backgroundColor = .white
        
        listingPic.contentMode = .scaleAspectFill
        listingPic.clipsToBounds = true
        listingPic.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = .boldSystemFont(ofSize: 28)
        
        sellerLabel.font = .systemFont(ofSize: 16)
        
        priceLabel.textColor = .lightBlue
        priceLabel.font = .boldSystemFont(ofSize: 24)
        
        contactLabel.font = .systemFont(ofSize: 14)
        
        categoryLabel.font = .systemFont(ofSize: 14)
        categoryLabel.layer.cornerRadius = 15
        categoryLabel.clipsToBounds = true
        categoryLabel.textAlignment = .center
        setLabelColor(for: categoryLabel, for: listing.category)
        
        locationLabel.font = .systemFont(ofSize: 14)
        locationLabel.layer.cornerRadius = 15
        locationLabel.clipsToBounds = true
        locationLabel.textAlignment = .center
        setLabelColor(for: locationLabel, for: listing.location)
        
        descriptionView.isScrollEnabled = false
        descriptionView.font = .systemFont(ofSize: 14)
        descriptionView.backgroundColor = .white
        
        availabilityView.isScrollEnabled = false
        availabilityView.font = .systemFont(ofSize: 14)
        availabilityView.backgroundColor = .white
        
        purchaseButton.backgroundColor = .lightBlue
        purchaseButton.setTitle("Purchase", for: .normal)
        purchaseButton.titleLabel?.textColor = .white
        purchaseButton.titleLabel!.font = .boldSystemFont(ofSize: 16)
        purchaseButton.layer.cornerRadius = 20
        purchaseButton.clipsToBounds = true
        purchaseButton.titleLabel!.textAlignment = .center
        purchaseButton.addTarget(self, action: #selector(buttonSelected(_:)), for: .touchUpInside)
        
        [titleLabel, sellerLabel, priceLabel, contactLabel, categoryLabel, locationLabel, descriptionView, availabilityView, purchaseButton].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            infoView.addSubview(subView)
        }
        
        listingPic.contentMode = .scaleAspectFill
        listingPic.clipsToBounds = true
        listingPic.translatesAutoresizingMaskIntoConstraints = false
        listingPic.image = UIImage(data: decodeBase64String(base64String: listing.picture))
        view.addSubview(listingPic)
        
        infoView.layer.masksToBounds = true
        infoView.clipsToBounds = false
        infoView.layer.cornerRadius = 15
        infoView.backgroundColor = .white
        infoView.layer.borderColor = UIColor.white.cgColor
        infoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoView)
        
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            listingPic.topAnchor.constraint(equalTo: view.topAnchor),
            listingPic.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listingPic.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listingPic.heightAnchor.constraint(equalToConstant: 350)
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 27),
            titleLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 26),
            titleLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -26)
        ])
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            priceLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 26)
        ])
        NSLayoutConstraint.activate([
            sellerLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 60),
            sellerLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -26)
        ])
        NSLayoutConstraint.activate([
            contactLabel.topAnchor.constraint(equalTo: sellerLabel.bottomAnchor, constant: 4),
            contactLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -26)
        ])
        NSLayoutConstraint.activate([
            categoryLabel.heightAnchor.constraint(equalToConstant: 30),
            categoryLabel.widthAnchor.constraint(equalToConstant: 70),
            categoryLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 30),
            categoryLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 26)
        ])
        NSLayoutConstraint.activate([
            locationLabel.heightAnchor.constraint(equalToConstant: 30),
            locationLabel.widthAnchor.constraint(equalToConstant: 80),
            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 30),
            locationLabel.leadingAnchor.constraint(equalTo: categoryLabel.trailingAnchor, constant: 5)
        ])
        NSLayoutConstraint.activate([
            descriptionView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 12),
            descriptionView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 26),
            descriptionView.widthAnchor.constraint(equalToConstant: 325)
        ])
        NSLayoutConstraint.activate([
            availabilityView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 2),
            availabilityView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 26),
            availabilityView.widthAnchor.constraint(equalToConstant: 325)
        ])
        NSLayoutConstraint.activate([
            purchaseButton.widthAnchor.constraint(equalToConstant: 200),
            purchaseButton.heightAnchor.constraint(equalToConstant: 40),
            purchaseButton.topAnchor.constraint(equalTo: availabilityView.bottomAnchor, constant: 16),
            purchaseButton.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 26)
        ])
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 327),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func decodeBase64String(base64String: String) -> Data {
        let newImageData = Data(base64Encoded: base64String)
        return newImageData!
    }
    
    @objc func buttonSelected(_ sender: UITapGestureRecognizer) {
        purchaseButton.backgroundColor = .black
        purchaseButton.setTitle("Purchased!", for: .normal)
        purchaseButton.titleLabel?.textColor = .white
        registerPurchase(listingId: listing.id, userId: user.id, token: token)
    }
    
    func registerPurchase(listingId: Int, userId: Int, token: String) {
        NetworkManager.purchaseListing(listing_id: listingId, user_id: userId, token: token, completion: { response in
            self.user = response
        })
    }
    
    func setLabelColor(for label: UILabel, for name: String) {
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
        case "North":
            hexCode = "BDE3FF"
        case "West":
            hexCode = "DFF9BF"
        case "Central":
            hexCode = "F2E7FF"
        case "CTown":
            hexCode = "FFE3E1"
        default:
            hexCode = "#F5F5F5"
        }
        
        label.backgroundColor = UIColor(hexString: hexCode)
        label.layer.borderColor = UIColor.clear.cgColor
    }
    
}
