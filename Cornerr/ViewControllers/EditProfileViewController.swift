//
//  EditProfileViewController.swift
//  Cornerr
//
//  Created by Tony Chen on 4/30/22.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    private var currentUser: User
    private var currentToken: String
    
    var parentController: ProfileViewController?
    var delegate: EditProfileViewControllerDelegate?
    
    var picInstructions = UILabel()
    var picImageView = UIImageView()
    var nameLabel = UILabel()
    var nameTextField = UITextField()
    var contactLabel = UILabel()
    var contactTextField = UITextField()
    var bioLabel = UILabel()
    var bioTextView = UITextView()
    
    init(user: User, token: String) {
        self.currentUser = user
        self.currentToken = token
        self.nameTextField.text = user.name
        self.contactTextField.text = user.contact
        self.bioTextView.text = user.bio
        super.init(nibName: nil, bundle: nil)
        if let pfp = currentUser.pfp {
            self.picImageView.image = UIImage(data: decodeBase64String(base64String: pfp))
        }
        else {
            self.picImageView.image = UIImage(named: "defaultpfp\(parentController!.defaultpfpInt)")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Profile"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(saveProfile))
        navigationController?.navigationBar.tintColor = .lightBlue
        
        [picInstructions, picImageView, nameLabel, nameTextField, contactLabel, contactTextField, bioLabel, bioTextView].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subView)
        }
        
        setUpUIComponents()
        setUpConstraints()
    }
    
    func setUpUIComponents() {
        picInstructions.text = "Tap on the image to change your profile picture"
        picInstructions.font = .systemFont(ofSize: 12)
        picInstructions.textColor = .systemGray
        
//        if let pfp = currentUser.pfp {
//            picImageView.image = UIImage(data: decodeBase64String(base64String: pfp))
//        }
//        else {
//            picImageView.image = UIImage(named: "defaultpfp\(parentController!.defaultpfpInt)")
//        }
        
        picImageView.layer.cornerRadius = 60
        picImageView.layer.masksToBounds = true
        picImageView.contentMode = .scaleAspectFill
        picImageView.clipsToBounds = true
        picImageView.isUserInteractionEnabled = true
        let picTap = UITapGestureRecognizer(target: self, action: #selector(chooseImageAction(_:)))
        picTap.numberOfTapsRequired = 1
        picImageView.addGestureRecognizer(picTap)
        
        let labelAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 20, weight: .semibold)]
        
        nameLabel.attributedText = NSAttributedString(string: "Name", attributes: labelAttributes)
        
        contactLabel.attributedText = NSAttributedString(string: "Contact", attributes: labelAttributes)
        
        bioLabel.attributedText = NSAttributedString(string: "Bio", attributes: labelAttributes)
        
        nameTextField.layer.borderWidth = 1.5
        nameTextField.layer.cornerRadius = 15
        nameTextField.layer.borderColor = .lightBlue
        nameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameTextField.frame.height))
        nameTextField.leftViewMode = .always
        
        contactTextField.layer.borderWidth = 1.5
        contactTextField.layer.cornerRadius = 15
        contactTextField.layer.borderColor = .lightBlue
        contactTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameTextField.frame.height))
        contactTextField.leftViewMode = .always
        
        bioTextView.layer.borderWidth = 1.5
        bioTextView.layer.cornerRadius = 15
        bioTextView.layer.borderColor = .lightBlue
    }
    
    func setUpConstraints() {
        let padding: CGFloat = 35
        
        NSLayoutConstraint.activate([
            picImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            picImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            picImageView.widthAnchor.constraint(equalToConstant: 120),
            picImageView.heightAnchor.constraint(equalToConstant: 120),
                
            picInstructions.topAnchor.constraint(equalTo: picImageView.bottomAnchor, constant: 15),
            picInstructions.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: picInstructions.bottomAnchor, constant: 25),
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            nameTextField.heightAnchor.constraint(equalToConstant: 30),
            
            contactLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 25),
            contactLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            
            contactTextField.topAnchor.constraint(equalTo: contactLabel.bottomAnchor, constant: 10),
            contactTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            contactTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            contactTextField.heightAnchor.constraint(equalToConstant: 30),
            
            bioLabel.topAnchor.constraint(equalTo: contactTextField.bottomAnchor, constant: 25),
            bioLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            
            bioTextView.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 10),
            bioTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            bioTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            bioTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func chooseImageAction(_ sender: Any) {
        showImagePickerOptions()
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
    
    @objc func saveProfile() {
        // name, bio, profile picture
        var arr: [String] = []
        arr.append(nameTextField.text!)
        arr.append(bioTextView.text!)
        arr.append(encodeBase64String(img: picImageView.image))
        networkEdit(id: currentUser.id, name: nameTextField.text!, contact: contactTextField.text!, bio: bioTextView.text, pfp: encodeBase64String(img: picImageView.image), token: currentToken)
        self.delegate?.retrieveData(arr)
        navigationController?.popViewController(animated: true)
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
    
    func networkEdit(id: Int, name: String, contact: String, bio: String, pfp: String, token: String) {
        NetworkManager.editUser(id: id, name: name, contact: contact, bio: bio, pfp: pfp, token: token, completion: { response in
            self.currentUser = response
        })
    }
    
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        picImageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
}


protocol EditProfileViewControllerDelegate {
    
    func retrieveData(_ str: [String])
    
}
