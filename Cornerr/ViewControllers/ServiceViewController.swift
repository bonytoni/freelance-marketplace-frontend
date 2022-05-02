//
//  ServiceViewController.swift
//  Cornerr
//
//  Created by Tony Chen on 5/1/22.
//

import UIKit

protocol ModelContainer: AnyObject {
    var services: [Listing] { get set }
}

class ServiceViewController: UIViewController {
    
    weak var delegate: ModelContainer?
    
    var dummyUser: SimpleUser = SimpleUser(id: 0, username: "tony", contact: "123")
    
    var headerLabel = UILabel()
    var photoView = UIImageView()
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var priceLabel = UILabel()
    var categoryLabel = UILabel()
    var locationLabel = UILabel()
    var availabilityLabel = UILabel()
    var titleTextField = UITextField()
    var descriptionTextView = UITextView()
    var priceTextField = UITextField()
    // no dropdown menu for now
    var categoryTextField = UITextField()
    var locationTextField = UITextField()
    var availabilityTextField = UITextField()
    
    var indexPath: Int = -1
    var originalService: Listing? {
        didSet {
            titleTextField.text = originalService?.title
            descriptionTextView.text = originalService?.description
            priceTextField.text = "\(String(describing: originalService?.price))"
            categoryTextField.text = originalService?.category
            locationTextField.text = originalService?.location
            availabilityTextField.text = originalService?.availability
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        if let service = originalService {
            headerLabel.text = "Edit Service"
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(publishSaveService))
        }
        else {
            headerLabel.text = "Add Service"
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Publish", style: .done, target: self, action: #selector(publishSaveService))
        }
        
        [headerLabel, photoView, titleLabel, descriptionLabel, priceLabel, categoryLabel, locationLabel, availabilityLabel, titleTextField, descriptionTextView, priceTextField, categoryTextField, locationTextField, availabilityTextField].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subView)
        }
        
        setUpUIComponents()
        setUpConstraints()
    }
    
    func setUpUIComponents() {
        headerLabel.textColor = .black
        headerLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        photoView.image = UIImage(named: "upload photos")
        photoView.layer.masksToBounds = true
        photoView.contentMode = .scaleAspectFill
        photoView.clipsToBounds = true
        
        let labelAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 18, weight: .semibold)]
        titleLabel.attributedText = NSAttributedString(string: "Service Title", attributes: labelAttributes)
        titleLabel.textColor = .black
        
        descriptionLabel.attributedText = NSAttributedString(string: "Description", attributes: labelAttributes)
        descriptionLabel.textColor = .black
        
        priceLabel.attributedText = NSAttributedString(string: "Price ($)", attributes: labelAttributes)
        priceLabel.textColor = .black
        
        categoryLabel.attributedText = NSAttributedString(string: "Category", attributes: labelAttributes)
        categoryLabel.textColor = .black
        
        locationLabel.attributedText = NSAttributedString(string: "Location", attributes: labelAttributes)
        locationLabel.textColor = .black
        
        availabilityLabel.attributedText = NSAttributedString(string: "Availability", attributes: labelAttributes)
        availabilityLabel.textColor = .black
        
        titleTextField.layer.borderWidth = 1
        titleTextField.layer.cornerRadius = 12
        titleTextField.layer.borderColor = .lightBlue
        titleTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: titleTextField.frame.height))
        titleTextField.leftViewMode = .always
        
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.cornerRadius = 12
        descriptionTextView.layer.borderColor = .lightBlue
        
        priceTextField.layer.borderWidth = 1
        priceTextField.layer.cornerRadius = 12
        priceTextField.layer.borderColor = .lightBlue
        priceTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: priceTextField.frame.height))
        priceTextField.leftViewMode = .always
        
        categoryTextField.layer.borderWidth = 1
        categoryTextField.layer.cornerRadius = 12
        categoryTextField.layer.borderColor = .lightBlue
        categoryTextField.placeholder = "Beauty, Fashion, Media, Tech, Crafts, Food"
        categoryTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: categoryTextField.frame.height))
        categoryTextField.leftViewMode = .always
        
        locationTextField.layer.borderWidth = 1
        locationTextField.layer.cornerRadius = 12
        locationTextField.layer.borderColor = .lightBlue
        locationTextField.placeholder = "North, West, Central, Collegetown"
        locationTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: locationTextField.frame.height))
        locationTextField.leftViewMode = .always
        
        availabilityTextField.layer.borderWidth = 1
        availabilityTextField.layer.cornerRadius = 12
        availabilityTextField.layer.borderColor = .lightBlue
        availabilityTextField.placeholder = "Mon, Tue, Wed, Thu, Fri, Sat, Sun"
        availabilityTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: locationTextField.frame.height))
        availabilityTextField.leftViewMode = .always
    }
    
    func setUpConstraints() {
        let padding: CGFloat = 25
        NSLayoutConstraint.activate([
            headerLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            photoView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            photoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoView.widthAnchor.constraint(equalToConstant: 200),
            photoView.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            titleTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            titleTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            titleTextField.heightAnchor.constraint(equalToConstant: 35),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 100),
            
            priceLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
            priceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            
            priceTextField.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            priceTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            priceTextField.widthAnchor.constraint(equalToConstant: 70),
            priceTextField.heightAnchor.constraint(equalToConstant: 35),
            
            categoryLabel.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 20),
            categoryLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            
            categoryTextField.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            categoryTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            categoryTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            categoryTextField.heightAnchor.constraint(equalToConstant: 35),
            
            locationLabel.topAnchor.constraint(equalTo: categoryTextField.bottomAnchor, constant: 20),
            locationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            
            locationTextField.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            locationTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            locationTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            locationTextField.heightAnchor.constraint(equalToConstant: 35),
            
            availabilityLabel.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 20),
            availabilityLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            
            availabilityTextField.topAnchor.constraint(equalTo: availabilityLabel.bottomAnchor, constant: 10),
            availabilityTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            availabilityTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            availabilityTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    func updateIndexPath(index: Int) {
        indexPath = index
    }
    
    @objc func publishSaveService() {
        let service = Listing(id: 0, unixTime: 0, title: titleTextField.text!, category: categoryTextField.text!, description: descriptionTextView.text, availability: availabilityTextField.text!, location: locationTextField.text!, price: 15, seller: dummyUser, buyers: [])
        if let s = originalService {
            self.delegate?.services.remove(at: indexPath)
            self.delegate?.services.append(service)
        }
        else {
            self.delegate?.services.append(service)
        }
        navigationController?.popViewController(animated: true)
    }
    
}
