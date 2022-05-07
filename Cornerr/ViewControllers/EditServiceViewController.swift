//
//  EditServiceViewController.swift
//  Cornerr
//
//  Created by Tony Chen on 5/1/22.
//

import UIKit

class EditServiceViewController: UIViewController, UITextFieldDelegate {
    
    private var currentUser: User
    private var simpleCurrentUser: SimpleUser
    private var currentToken: String
            
    var newListing: SimpleListing!
    var fullListing: Listing!
    
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
    var availabilityTextField = UITextField()
    
    var selectedCategory = UILabel()
    // buttons for category
    var beautyButton = UIButton()
    var fashionButton = UIButton()
    var mediaButton = UIButton()
    var techButton = UIButton()
    var craftsButton = UIButton()
    var foodButton = UIButton()
    var otherCategoryButton = UIButton()
    
    var selectedLocation = UILabel()
    // buttons for location
    var northButton = UIButton()
    var westButton = UIButton()
    var centralButton = UIButton()
    var collegetownButton = UIButton()
    var otherLocationButton = UIButton()
    
    var saveButton = UIButton()
    var closeImageView = UIImageView()
    var deleteButton = UIImageView()
    
    var indexPath: Int = -1
    var originalService: SimpleListing
    
    init(user: User, token: String, originalService: SimpleListing) {
        self.currentUser = user
        self.currentToken = token
        self.simpleCurrentUser = SimpleUser(id: user.id, username: user.username, contact: user.contact)
        self.originalService = originalService
        self.titleTextField.text = originalService.title
        self.descriptionTextView.text = originalService.description
        self.priceTextField.text = "\(originalService.price)"
        self.selectedCategory.text = originalService.category
        self.selectedLocation.text = originalService.location
        self.availabilityTextField.text = originalService.availability
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let saveButtonAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 18, weight: .semibold)]
        headerLabel.text = "Edit Service"
        saveButton.setAttributedTitle(NSAttributedString(string: "Save", attributes: saveButtonAttributes), for: .normal)
        
        [headerLabel, photoView, titleLabel, descriptionLabel, priceLabel, categoryLabel, locationLabel, availabilityLabel, titleTextField, descriptionTextView, priceTextField, availabilityTextField, selectedCategory, beautyButton, fashionButton, mediaButton, techButton, craftsButton, foodButton, otherCategoryButton, selectedLocation, northButton, westButton, centralButton, collegetownButton, otherLocationButton, saveButton, closeImageView, deleteButton].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subView)
        }
        
        setUpUIComponents()
        setUpConstraints()
    }
    
    func setUpUIComponents() {
        headerLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        photoView.image = UIImage(data: decodeBase64String(base64String: originalService.picture))
        photoView.layer.masksToBounds = true
        photoView.contentMode = .scaleAspectFill
        photoView.clipsToBounds = true
        photoView.layer.cornerRadius = 14
        photoView.isUserInteractionEnabled = true
        let photoTap = UITapGestureRecognizer(target: self, action: #selector(chooseImageAction(_:)))
        photoTap.numberOfTapsRequired = 1
        photoView.addGestureRecognizer(photoTap)
        
        let labelAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]
        titleLabel.attributedText = NSAttributedString(string: "Service Title", attributes: labelAttributes)
        
        descriptionLabel.attributedText = NSAttributedString(string: "Description", attributes: labelAttributes)
        
        priceLabel.attributedText = NSAttributedString(string: "Price ($)", attributes: labelAttributes)
        
        categoryLabel.attributedText = NSAttributedString(string: "Category:", attributes: labelAttributes)
        
        locationLabel.attributedText = NSAttributedString(string: "Location:", attributes: labelAttributes)
        
        availabilityLabel.attributedText = NSAttributedString(string: "Availability", attributes: labelAttributes)
        
        titleTextField.font = .systemFont(ofSize: 16)
        titleTextField.layer.borderWidth = 1
        titleTextField.layer.cornerRadius = 12
        titleTextField.layer.borderColor = .lightBlue
        titleTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: titleTextField.frame.height))
        titleTextField.leftViewMode = .always
        titleTextField.autocorrectionType = .no
        titleTextField.autocapitalizationType = .none
        
        descriptionTextView.font = .systemFont(ofSize: 16)
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.cornerRadius = 16
        descriptionTextView.layer.borderColor = .lightBlue
        descriptionTextView.autocapitalizationType = .none
        
        priceTextField.font = .systemFont(ofSize: 16)
        priceTextField.layer.borderWidth = 1
        priceTextField.layer.cornerRadius = 12
        priceTextField.layer.borderColor = .lightBlue
        priceTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: priceTextField.frame.height))
        priceTextField.leftViewMode = .always
        priceTextField.delegate = self
        
        availabilityTextField.font = .systemFont(ofSize: 16)
        availabilityTextField.layer.borderWidth = 1
        availabilityTextField.layer.cornerRadius = 12
        availabilityTextField.layer.borderColor = .lightBlue
        availabilityTextField.placeholder = "Ex: Mon 2-4PM, Wed any time"
        availabilityTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: availabilityTextField.frame.height))
        availabilityTextField.leftViewMode = .always
        availabilityTextField.autocapitalizationType = .none
        availabilityTextField.autocorrectionType = .no
        
        selectedCategory.font = .systemFont(ofSize: 14, weight: .regular)
        
        selectedLocation.font = .systemFont(ofSize: 14, weight: .regular)
        
        applyButtonProperties(beautyButton, "Beauty", "category")
        applyButtonProperties(fashionButton, "Fashion", "category")
        applyButtonProperties(mediaButton, "Media", "category")
        applyButtonProperties(techButton, "Tech", "category")
        applyButtonProperties(craftsButton, "Crafts", "category")
        applyButtonProperties(foodButton, "Food", "category")
        applyButtonProperties(otherCategoryButton, "Other", "category")
        applyButtonProperties(northButton, "North", "location")
        applyButtonProperties(westButton, "West", "location")
        applyButtonProperties(centralButton, "Central", "location")
        applyButtonProperties(collegetownButton, "CTown", "location")
        applyButtonProperties(otherLocationButton, "Other", "location")
        
        saveButton.setTitleColor(.lightBlue, for: .normal)
        saveButton.addTarget(self, action: #selector(saveService), for: .touchUpInside)
        
        closeImageView.image = UIImage(named: "close")
        closeImageView.contentMode = .scaleAspectFill
        closeImageView.clipsToBounds = true
        closeImageView.isUserInteractionEnabled = true
        let closeTap = UITapGestureRecognizer(target: self, action: #selector(closeVC))
        closeTap.numberOfTapsRequired = 1
        closeImageView.addGestureRecognizer(closeTap)
        
        deleteButton.image = UIImage(named: "delete")
        deleteButton.isUserInteractionEnabled = true
        let delete = UITapGestureRecognizer(target: self, action: #selector(deleteService))
        delete.numberOfTapsRequired = 1
        deleteButton.addGestureRecognizer(delete)
    }
    
    func setUpConstraints() {
        let padding: CGFloat = 25
        let buttonPadding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            photoView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            photoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            photoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            photoView.heightAnchor.constraint(equalToConstant: 160),
            
            titleLabel.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            titleTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            titleTextField.widthAnchor.constraint(equalToConstant: 250),
            titleTextField.heightAnchor.constraint(equalToConstant: 35),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 15),
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 75),
            
            priceLabel.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 15),
            priceLabel.leftAnchor.constraint(equalTo: priceTextField.leftAnchor),
            
            priceTextField.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            priceTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            priceTextField.widthAnchor.constraint(equalToConstant: 70),
            priceTextField.heightAnchor.constraint(equalToConstant: 30),
            
            categoryLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 15),
            categoryLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            
            selectedCategory.centerYAnchor.constraint(equalTo: categoryLabel.centerYAnchor),
            selectedCategory.leftAnchor.constraint(equalTo: categoryLabel.rightAnchor, constant: buttonPadding),
            
            // category buttons
            beautyButton.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            beautyButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            beautyButton.widthAnchor.constraint(equalToConstant: 60),
            beautyButton.heightAnchor.constraint(equalToConstant: 25),
            fashionButton.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            fashionButton.leftAnchor.constraint(equalTo: beautyButton.rightAnchor, constant: buttonPadding),
            fashionButton.widthAnchor.constraint(equalToConstant: 60),
            fashionButton.heightAnchor.constraint(equalToConstant: 25),
            mediaButton.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            mediaButton.leftAnchor.constraint(equalTo: fashionButton.rightAnchor, constant: buttonPadding),
            mediaButton.widthAnchor.constraint(equalToConstant: 60),
            mediaButton.heightAnchor.constraint(equalToConstant: 25),
            techButton.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            techButton.leftAnchor.constraint(equalTo: mediaButton.rightAnchor, constant: buttonPadding),
            techButton.widthAnchor.constraint(equalToConstant: 60),
            techButton.heightAnchor.constraint(equalToConstant: 25),
            craftsButton.topAnchor.constraint(equalTo: beautyButton.bottomAnchor, constant: 10),
            craftsButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            craftsButton.widthAnchor.constraint(equalToConstant: 60),
            craftsButton.heightAnchor.constraint(equalToConstant: 25),
            foodButton.topAnchor.constraint(equalTo: beautyButton.bottomAnchor, constant: 10),
            foodButton.leftAnchor.constraint(equalTo: craftsButton.rightAnchor, constant: buttonPadding),
            foodButton.widthAnchor.constraint(equalToConstant: 60),
            foodButton.heightAnchor.constraint(equalToConstant: 25),
            otherCategoryButton.topAnchor.constraint(equalTo: beautyButton.bottomAnchor, constant: 10),
            otherCategoryButton.leftAnchor.constraint(equalTo: foodButton.rightAnchor, constant: buttonPadding),
            otherCategoryButton.widthAnchor.constraint(equalToConstant: 60),
            otherCategoryButton.heightAnchor.constraint(equalToConstant: 25),
            
            locationLabel.topAnchor.constraint(equalTo: foodButton.bottomAnchor, constant: 15),
            locationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            
            selectedLocation.centerYAnchor.constraint(equalTo: locationLabel.centerYAnchor),
            selectedLocation.leftAnchor.constraint(equalTo: locationLabel.rightAnchor, constant: buttonPadding),
            
            // location buttons
            northButton.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            northButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            northButton.widthAnchor.constraint(equalToConstant: 60),
            northButton.heightAnchor.constraint(equalToConstant: 25),
            westButton.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            westButton.leftAnchor.constraint(equalTo: northButton.rightAnchor, constant: buttonPadding),
            westButton.widthAnchor.constraint(equalToConstant: 60),
            westButton.heightAnchor.constraint(equalToConstant: 25),
            centralButton.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            centralButton.leftAnchor.constraint(equalTo: westButton.rightAnchor, constant: buttonPadding),
            centralButton.widthAnchor.constraint(equalToConstant: 60),
            centralButton.heightAnchor.constraint(equalToConstant: 25),
            collegetownButton.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            collegetownButton.leftAnchor.constraint(equalTo: centralButton.rightAnchor, constant: buttonPadding),
            collegetownButton.widthAnchor.constraint(equalToConstant: 60),
            collegetownButton.heightAnchor.constraint(equalToConstant: 25),
            otherLocationButton.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            otherLocationButton.leftAnchor.constraint(equalTo: collegetownButton.rightAnchor, constant: buttonPadding),
            otherLocationButton.widthAnchor.constraint(equalToConstant: 60),
            otherLocationButton.heightAnchor.constraint(equalToConstant: 25),
            
            availabilityLabel.topAnchor.constraint(equalTo: northButton.bottomAnchor, constant: 15),
            availabilityLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            
            availabilityTextField.topAnchor.constraint(equalTo: availabilityLabel.bottomAnchor, constant: 10),
            availabilityTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            availabilityTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            availabilityTextField.heightAnchor.constraint(equalToConstant: 35),
            
            saveButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            closeImageView.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            closeImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            closeImageView.widthAnchor.constraint(equalToConstant: 25),
            closeImageView.heightAnchor.constraint(equalToConstant: 25),
            
            deleteButton.topAnchor.constraint(equalTo: availabilityTextField.bottomAnchor, constant: 15),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        return imagePicker
    }
    
    // Method provided with Haiying's help https://medium.com/nerd-for-tech/how-to-display-an-image-picker-controller-using-swift-5cfa9892d0b6
    func showImagePickerOptions() {
        let alertVC = UIAlertController(title: "Pick a Photo", message: "Choose a photo from Library", preferredStyle: .actionSheet)
        
        // Image picker for Library
        let libraryAction = UIAlertAction(title: "Library", style: .default) { [weak self] (action) in
            // Capture self to avoid retain cycles
            guard let self = self else {
                return
            }
            let libraryImagePicker = self.imagePicker(sourceType: .photoLibrary)
            libraryImagePicker.delegate = self
            self.present(libraryImagePicker, animated: true) {
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertVC.addAction(libraryAction)
        alertVC.addAction(cancelAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func applyButtonProperties(_ button: UIButton, _ name: String, _ tag: String) {
        setButtonColor(button, for: name)
        let titleAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 12, weight: .regular)]
        button.setAttributedTitle(NSAttributedString(string: name, attributes: titleAttributes), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        if tag == "category" {
            button.addTarget(self, action: #selector(categorySelectedButton(_:)), for: .touchUpInside)
        }
        if tag == "location" {
            button.addTarget(self, action: #selector(locationSelectedButton(_:)), for: .touchUpInside)
        }
    }
    
    func setButtonColor(_ button: UIButton, for name: String) {
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
        
        button.backgroundColor = UIColor(hexString: hexCode)
        button.layer.borderColor = UIColor.clear.cgColor
    }
    
    @objc func categorySelectedButton(_ sender: UIButton) {
        switch sender {
        case beautyButton:
            selectedCategory.text = "Beauty"
        case fashionButton:
            selectedCategory.text = "Fashion"
        case mediaButton:
            selectedCategory.text = "Media"
        case techButton:
            selectedCategory.text = "Tech"
        case craftsButton:
            selectedCategory.text = "Crafts"
        case foodButton:
            selectedCategory.text = "Food"
        default:
            selectedCategory.text = "Other"
        }
    }
    
    @objc func locationSelectedButton(_ sender: UIButton) {
        switch sender {
        case northButton:
            selectedLocation.text = "North"
        case westButton:
            selectedLocation.text = "West"
        case centralButton:
            selectedLocation.text = "Central"
        case collegetownButton:
            selectedLocation.text = "CTown"
        default:
            selectedLocation.text = "Other"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func updateIndexPath(index: Int) {
        indexPath = index
    }
    
    @objc func saveService() {
        if (!titleTextField.hasText || !descriptionTextView.hasText || !availabilityTextField.hasText || !priceTextField.hasText) {
            let alertVC = UIAlertController(title: "Invalid Fields", message: "Please enter something into your fields", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertVC.addAction(cancelAction)
            self.present(alertVC, animated: true, completion: nil)
        }
        else if (priceTextField.hasText && ((priceTextField.text!.first == "0" && priceTextField.text!.count > 1) || priceTextField.text!.count > 3)) {
            var str: String = ""
            if (priceTextField.text!.first == "0" && priceTextField.text!.count > 1) {
                str = "Enter a price again without a leading 0"
            }
            if (priceTextField.text!.count > 3) {
                str = "Price must be less than $1000"
            }
            let alertVC = UIAlertController(title: "Invalid price for service", message: str, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertVC.addAction(cancelAction)
            self.present(alertVC, animated: true, completion: nil)
        }
        else {
            editListing(id: originalService.id, title: titleTextField.text!, category: selectedCategory.text!, description: descriptionTextView.text, availability: availabilityTextField.text!, location: selectedLocation.text!, price: Int(priceTextField.text!)!, picture: encodeBase64String(img: photoView.image), token: currentToken)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func editListing(id: Int, title: String, category: String, description: String, availability: String, location: String, price: Int, picture: String, token: String) {
        NetworkManager.editListing(id: id, title: title, category: category, description: description, availability: availability, location: location, price: price, picture: picture, token: token, completion: { listing in
        })
    }
    
    func removeListing (id: Int, token: String) {
        NetworkManager.deleteListing(id: id, token: token, completion: { response in
            self.closeVC()
        })
    }
    
    @objc func deleteService() {
        removeListing(id: originalService.id, token: currentToken)
    }
    
    @objc func chooseImageAction(_ sender: Any) {
        showImagePickerOptions()
    }
    
    @objc func closeVC() {
        dismiss(animated: true, completion: nil)
    }
    
    func encodeBase64String(img: UIImage?) -> String {
        let imgData = img?.jpegData(compressionQuality: 1)
        let imgBase64String = imgData?.base64EncodedString()
        return imgBase64String!
    }
    
    func decodeBase64String(base64String: String) -> Data {
        let newImageData = Data(base64Encoded: base64String)
        return newImageData!
    }
    
}

extension EditServiceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        photoView.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
}
