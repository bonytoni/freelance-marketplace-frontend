//
//  LoginViewController.swift
//  Cornerr
//
//  Created by Tony Chen on 5/3/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    var homeContainer = UIView()
    var logoView = UIView()
    var logoImage = UIImageView()
    var welcomeLabel = UILabel()
    var sloganText = UITextView()
    var signUpButton = UIButton()
    var loginButton = UIButton()
    
    var signUpContainer = UIView()
    var bannerImage = UIImageView()
    var logoImage2 = UIImageView()
    var headerLabel = UILabel()
    var nameImage = UIImageView()
    var usernameImage = UIImageView()
    var passwordImage = UIImageView()
    var contactImage = UIImageView()
    var nameTextField = UITextField()
    var usernameTextField = UITextField()
    var passwordTextField = UITextField()
    var contactTextField = UITextField()
    var finishedSignUpButton = UIButton()
    
    var loginContainer = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setUpHomeUIComponents()
        setUpHomeContraints()
        
        setUpSignUpUIComponents()
        setUpSignUpConstraints()
        
        setUpLoginUIComponents()
        setUpLoginConstraints()
    }
    
    func setUpHomeUIComponents() {
        homeContainer.layer.masksToBounds = true
        homeContainer.clipsToBounds = false
        homeContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(homeContainer)
        
        logoView.layer.masksToBounds = true
        logoView.clipsToBounds = false
        logoView.translatesAutoresizingMaskIntoConstraints = false
        
        welcomeLabel.text = "Welcome to"
        welcomeLabel.textColor = .blue
        welcomeLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        welcomeLabel.clipsToBounds = true
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        logoView.addSubview(welcomeLabel)
        
        logoImage.image = UIImage(named: "circus logo")
        logoImage.clipsToBounds = true
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoView.addSubview(logoImage)
        
        sloganText.text = "connecting you to on-campus freelancers"
        sloganText.textColor = UIColor.init(hexString: "#9D9D9D")
        sloganText.font = .systemFont(ofSize: 16, weight: .semibold)
        sloganText.isEditable = false
        sloganText.isScrollEnabled = false
        sloganText.isSelectable = false
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
        signUpButton.setAttributedTitle(NSAttributedString(string: "Sign Up", attributes: attributes), for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.layer.cornerRadius = 27
        signUpButton.backgroundColor = .lightBlue
        signUpButton.addTarget(self, action: #selector(pressedSignUp), for: .touchUpInside)
        
        loginButton.setAttributedTitle(NSAttributedString(string: "Login", attributes: attributes), for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.layer.cornerRadius = 27
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.borderWidth = 2
        
        [logoView, sloganText, signUpButton, loginButton].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            homeContainer.addSubview(subView)
        }
    }
    
    func setUpHomeContraints() {
        NSLayoutConstraint.activate([
            homeContainer.topAnchor.constraint(equalTo: view.topAnchor),
            homeContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeContainer.leftAnchor.constraint(equalTo: view.leftAnchor),
            homeContainer.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            logoView.widthAnchor.constraint(equalToConstant: 286),
            logoView.heightAnchor.constraint(equalToConstant: 100),
            
            welcomeLabel.topAnchor.constraint(equalTo: logoView.topAnchor),
            welcomeLabel.leftAnchor.constraint(equalTo: logoView.leftAnchor),
            
            logoImage.topAnchor.constraint(equalTo: logoView.topAnchor),
            logoView.leftAnchor.constraint(equalTo: logoView.leftAnchor),
            
            sloganText.topAnchor.constraint(equalTo: logoView.bottomAnchor),
            sloganText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sloganText.widthAnchor.constraint(equalToConstant: 286),
            sloganText.heightAnchor.constraint(equalToConstant: 55),
            
            signUpButton.topAnchor.constraint(equalTo: sloganText.bottomAnchor, constant: 25),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: 281),
            signUpButton.heightAnchor.constraint(equalToConstant: 45),
            
            loginButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 281),
            loginButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func setUpSignUpUIComponents() {
        signUpContainer.layer.masksToBounds = true
        signUpContainer.clipsToBounds = false
        signUpContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signUpContainer)
        signUpContainer.isHidden = true
        signUpContainer.isUserInteractionEnabled = false
        
        bannerImage.image = UIImage(named: "banners")
        bannerImage.clipsToBounds = true
        
        logoImage2.image = UIImage(named: "logo")
        logoImage2.clipsToBounds = true
        
        headerLabel.text = "Sign Up"
        headerLabel.font = .systemFont(ofSize: 32, weight: .semibold)
        
        nameImage.image = UIImage(named: "name")
        
        usernameImage.image = UIImage(named: "username")
        
        passwordImage.image = UIImage(named: "password")
        
        contactImage.image = UIImage(named: "contact")
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16, weight: .regular), .foregroundColor: UIColor.lightBlue]
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Full Name", attributes: placeholderAttributes)
        nameTextField.font = .systemFont(ofSize: 16, weight: .regular)
        nameTextField.addBottomBorder()
        
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: placeholderAttributes)
        usernameTextField.font = .systemFont(ofSize: 16, weight: .regular)
        usernameTextField.addBottomBorder()
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: placeholderAttributes)
        passwordTextField.font = .systemFont(ofSize: 16, weight: .regular)
        passwordTextField.addBottomBorder()
        
        contactTextField.attributedPlaceholder = NSAttributedString(string: "Contact Information", attributes: placeholderAttributes)
        contactTextField.font = .systemFont(ofSize: 16, weight: .regular)
        contactTextField.addBottomBorder()
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
        finishedSignUpButton.setAttributedTitle(NSAttributedString(string: "Sign Up", attributes: attributes), for: .normal)
        finishedSignUpButton.setTitleColor(.white, for: .normal)
        finishedSignUpButton.layer.cornerRadius = 27
        finishedSignUpButton.backgroundColor = .lightBlue
        finishedSignUpButton.addTarget(self, action: #selector(sucessfullySignedUp), for: .touchUpInside)
        
        [bannerImage, logoImage2, headerLabel, nameImage, usernameImage, passwordImage, contactImage, nameTextField, usernameTextField, passwordTextField, contactTextField, finishedSignUpButton].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            signUpContainer.addSubview(subView)
        }
    }
    
    func setUpSignUpConstraints() {
        NSLayoutConstraint.activate([
            signUpContainer.topAnchor.constraint(equalTo: view.topAnchor),
            signUpContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            signUpContainer.leftAnchor.constraint(equalTo: view.leftAnchor),
            signUpContainer.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            bannerImage.topAnchor.constraint(equalTo: view.topAnchor),
            bannerImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            logoImage2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoImage2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            headerLabel.topAnchor.constraint(equalTo: logoImage2.bottomAnchor, constant: 40),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameImage.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 35),
            nameImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 45),
            
            usernameImage.topAnchor.constraint(equalTo: nameImage.bottomAnchor, constant: 35),
            usernameImage.leftAnchor.constraint(equalTo: nameImage.leftAnchor),
            
            passwordImage.topAnchor.constraint(equalTo: usernameImage.bottomAnchor, constant: 35),
            passwordImage.leftAnchor.constraint(equalTo: nameImage.leftAnchor),
            
            contactImage.topAnchor.constraint(equalTo: passwordImage.bottomAnchor, constant: 35),
            contactImage.leftAnchor.constraint(equalTo: nameImage.leftAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: nameImage.topAnchor),
            nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            
            usernameTextField.topAnchor.constraint(equalTo: usernameImage.topAnchor),
            usernameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordImage.topAnchor),
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            
            contactTextField.topAnchor.constraint(equalTo: contactImage.topAnchor),
            contactTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            
            finishedSignUpButton.topAnchor.constraint(equalTo: contactTextField.bottomAnchor, constant: 45),
            finishedSignUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            finishedSignUpButton.widthAnchor.constraint(equalToConstant: 281),
            finishedSignUpButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func setUpLoginUIComponents() {
        
    }
    
    func setUpLoginConstraints() {
        
    }
    
    @objc func pressedSignUp() {
        homeContainer.isHidden = true
        homeContainer.isUserInteractionEnabled = false
        signUpContainer.isHidden = false
        signUpContainer.isUserInteractionEnabled = true
    }
    
    @objc func pressedLogin() {
        homeContainer.isHidden = true
        homeContainer.isUserInteractionEnabled = false
        loginContainer.isHidden = false
        loginContainer.isUserInteractionEnabled = true
    }
    
    @objc func sucessfullySignedUp() {
        
    }
    
}
