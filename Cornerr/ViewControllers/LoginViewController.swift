//
//  LoginViewController.swift
//  Cornerr
//
//  Created by Tony Chen on 5/3/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var session_token: String = ""
    private var currentUser: User!
    
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
    var alreadyHaveAccountLabel = UILabel()
    var alreadyHaveAccountButton = UIButton()
    
    var loginContainer = UIView()
    var logoImage3 = UIImageView()
    var headerLabel2 = UILabel()
    var usernameImage2 = UIImageView()
    var passwordImage2 = UIImageView()
    var usernameTextField2 = UITextField()
    var passwordTextField2 = UITextField()
    var finishedLoginButton = UIButton()
    var noAccountLabel = UILabel()
    var noAccountButton = UIButton()
    
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
        
        welcomeLabel.text = "welcome to"
        welcomeLabel.textColor = .blue
        welcomeLabel.font = .systemFont(ofSize: 28, weight: .medium)
        welcomeLabel.clipsToBounds = true
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        logoView.addSubview(welcomeLabel)
        
        logoImage.image = UIImage(named: "circus logo")
        logoImage.clipsToBounds = true
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoView.addSubview(logoImage)
        
        sloganText.text = "     connecting you to on-campus freelancers"
        sloganText.textColor = UIColor.init(hexString: "#9D9D9D")
        sloganText.font = .systemFont(ofSize: 18, weight: .semibold)
        sloganText.textAlignment = .right
        sloganText.isEditable = false
        sloganText.isScrollEnabled = false
        sloganText.isSelectable = false
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
        signUpButton.setAttributedTitle(NSAttributedString(string: "Sign Up", attributes: attributes), for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.layer.cornerRadius = 22
        signUpButton.backgroundColor = .lightBlue
        signUpButton.addTarget(self, action: #selector(pressedSignUp), for: .touchUpInside)
        
        loginButton.setAttributedTitle(NSAttributedString(string: "Login", attributes: attributes), for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.layer.cornerRadius = 22
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.borderWidth = 2
        loginButton.addTarget(self, action: #selector(pressedLogin), for: .touchUpInside)
        
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
            
            welcomeLabel.topAnchor.constraint(equalTo: logoView.topAnchor, constant: -5),
            welcomeLabel.leftAnchor.constraint(equalTo: logoView.leftAnchor),
            
            logoImage.topAnchor.constraint(equalTo: logoView.topAnchor),
            logoView.leftAnchor.constraint(equalTo: logoView.leftAnchor),
            
            sloganText.topAnchor.constraint(equalTo: logoView.bottomAnchor),
            sloganText.rightAnchor.constraint(equalTo: logoImage.rightAnchor),
            sloganText.widthAnchor.constraint(equalToConstant: 210),
            sloganText.heightAnchor.constraint(equalToConstant: 60),
            
            signUpButton.topAnchor.constraint(equalTo: sloganText.bottomAnchor, constant: 150),
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
        nameTextField.autocapitalizationType = .words
        
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: placeholderAttributes)
        usernameTextField.font = .systemFont(ofSize: 16, weight: .regular)
        usernameTextField.addBottomBorder()
        usernameTextField.autocapitalizationType = .none
        usernameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: placeholderAttributes)
        passwordTextField.font = .systemFont(ofSize: 16, weight: .regular)
        passwordTextField.addBottomBorder()
        passwordTextField.autocapitalizationType = .none
        
        contactTextField.attributedPlaceholder = NSAttributedString(string: "Contact Information", attributes: placeholderAttributes)
        contactTextField.font = .systemFont(ofSize: 16, weight: .regular)
        contactTextField.addBottomBorder()
        contactTextField.autocapitalizationType = .none
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
        finishedSignUpButton.setAttributedTitle(NSAttributedString(string: "Sign Up", attributes: attributes), for: .normal)
        finishedSignUpButton.setTitleColor(.white, for: .normal)
        finishedSignUpButton.layer.cornerRadius = 22
        finishedSignUpButton.backgroundColor = .lightBlue
        finishedSignUpButton.addTarget(self, action: #selector(successfullySignedUp), for: .touchUpInside)
        
        alreadyHaveAccountLabel.text = "Already have an account?"
        alreadyHaveAccountLabel.font = .systemFont(ofSize: 16, weight: .regular)
        
        let attributes2: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16, weight: .bold), .foregroundColor: UIColor.init(hexString: "#7BA3FF")]
        alreadyHaveAccountButton.setAttributedTitle(NSAttributedString(string: "Login", attributes: attributes2), for: .normal)
        alreadyHaveAccountButton.addTarget(self, action: #selector(switchToLogin), for: .touchUpInside)
        
        [bannerImage, logoImage2, headerLabel, nameImage, usernameImage, passwordImage, contactImage, nameTextField, usernameTextField, passwordTextField, contactTextField, finishedSignUpButton, alreadyHaveAccountLabel, alreadyHaveAccountButton].forEach { subView in
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
            nameTextField.widthAnchor.constraint(equalToConstant: 260),
            
            usernameTextField.topAnchor.constraint(equalTo: usernameImage.topAnchor),
            usernameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            usernameTextField.widthAnchor.constraint(equalToConstant: 260),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordImage.topAnchor),
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            passwordTextField.widthAnchor.constraint(equalToConstant: 260),
            
            contactTextField.topAnchor.constraint(equalTo: contactImage.topAnchor),
            contactTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            contactTextField.widthAnchor.constraint(equalToConstant: 260),
            
            finishedSignUpButton.topAnchor.constraint(equalTo: contactTextField.bottomAnchor, constant: 45),
            finishedSignUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            finishedSignUpButton.widthAnchor.constraint(equalToConstant: 281),
            finishedSignUpButton.heightAnchor.constraint(equalToConstant: 45),
            
            alreadyHaveAccountLabel.topAnchor.constraint(equalTo: finishedSignUpButton.bottomAnchor, constant: 25),
            alreadyHaveAccountLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 74),
            
            alreadyHaveAccountButton.centerYAnchor.constraint(equalTo: alreadyHaveAccountLabel.centerYAnchor),
            alreadyHaveAccountButton.leftAnchor.constraint(equalTo: alreadyHaveAccountLabel.rightAnchor, constant: 5)
        ])
    }
    
    func setUpLoginUIComponents() {
        loginContainer.layer.masksToBounds = true
        loginContainer.clipsToBounds = false
        loginContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginContainer)
        loginContainer.isHidden = true
        loginContainer.isUserInteractionEnabled = false
        
        logoImage3.image = UIImage(named: "logo fun")
        logoImage3.clipsToBounds = true
        
        headerLabel2.text = "Login"
        headerLabel2.font = .systemFont(ofSize: 32, weight: .semibold)
        
        usernameImage2.image = UIImage(named: "username")
        
        passwordImage2.image = UIImage(named: "password")
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16, weight: .regular), .foregroundColor: UIColor.lightBlue]
        usernameTextField2.attributedPlaceholder = NSAttributedString(string: "Username", attributes: placeholderAttributes)
        usernameTextField2.font = .systemFont(ofSize: 16, weight: .regular)
        usernameTextField2.addBottomBorder()
        usernameTextField2.autocapitalizationType = .none
        usernameTextField2.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        passwordTextField2.attributedPlaceholder = NSAttributedString(string: "Password", attributes: placeholderAttributes)
        passwordTextField2.font = .systemFont(ofSize: 16, weight: .regular)
        passwordTextField2.addBottomBorder()
        passwordTextField2.autocapitalizationType = .none
        passwordTextField2.isSecureTextEntry = true
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
        finishedLoginButton.setAttributedTitle(NSAttributedString(string: "Login", attributes: attributes), for: .normal)
        finishedLoginButton.setTitleColor(.black, for: .normal)
        finishedLoginButton.layer.cornerRadius = 22
        finishedLoginButton.layer.borderColor = UIColor.black.cgColor
        finishedLoginButton.layer.borderWidth = 2
        finishedLoginButton.addTarget(self, action: #selector(checkLogin), for: .touchUpInside)
        
        noAccountLabel.text = "Don't have an account?"
        noAccountLabel.font = .systemFont(ofSize: 16, weight: .regular)
        
        let attributes2: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16, weight: .bold), .foregroundColor: UIColor.init(hexString: "#7BA3FF")]
        noAccountButton.setAttributedTitle(NSAttributedString(string: "Sign Up", attributes: attributes2), for: .normal)
        noAccountButton.addTarget(self, action: #selector(switchToSignUp), for: .touchUpInside)
        
        [logoImage3, headerLabel2, usernameImage2, passwordImage2, usernameTextField2, passwordTextField2, finishedLoginButton, noAccountLabel, noAccountButton].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            loginContainer.addSubview(subView)
        }
    }
    
    func setUpLoginConstraints() {
        NSLayoutConstraint.activate([
            loginContainer.topAnchor.constraint(equalTo: view.topAnchor),
            loginContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loginContainer.leftAnchor.constraint(equalTo: view.leftAnchor),
            loginContainer.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            logoImage3.bottomAnchor.constraint(equalTo: headerLabel2.topAnchor, constant: -20),
            logoImage3.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
            headerLabel2.topAnchor.constraint(equalTo: headerLabel.topAnchor),
            headerLabel2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            usernameImage2.topAnchor.constraint(equalTo: nameImage.topAnchor),
            usernameImage2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 45),
            
            passwordImage2.topAnchor.constraint(equalTo: usernameImage2.bottomAnchor, constant: 35),
            passwordImage2.leftAnchor.constraint(equalTo: usernameImage2.leftAnchor),
            
            usernameTextField2.topAnchor.constraint(equalTo: usernameImage2.topAnchor),
            usernameTextField2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            usernameTextField2.widthAnchor.constraint(equalToConstant: 260),
            
            passwordTextField2.topAnchor.constraint(equalTo: passwordImage2.topAnchor),
            passwordTextField2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            passwordTextField2.widthAnchor.constraint(equalToConstant: 260),
            
            finishedLoginButton.topAnchor.constraint(equalTo: finishedSignUpButton.topAnchor),
            finishedLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            finishedLoginButton.widthAnchor.constraint(equalToConstant: 281),
            finishedLoginButton.heightAnchor.constraint(equalToConstant: 45),
            
            noAccountLabel.topAnchor.constraint(equalTo: finishedLoginButton.bottomAnchor, constant: 25),
            noAccountLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 74),
            
            noAccountButton.centerYAnchor.constraint(equalTo: noAccountLabel.centerYAnchor),
            noAccountButton.leftAnchor.constraint(equalTo: noAccountLabel.rightAnchor, constant: 5)
        ])
    }
    
    // only lowercase letters are allowed for usernames
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text: String = textField.text {
            DispatchQueue.main.async {
                textField.text = text.lowercased()
            }
        }
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
    
    @objc func switchToLogin() {
        signUpContainer.isHidden = true
        signUpContainer.isUserInteractionEnabled = false
        loginContainer.isHidden = false
        loginContainer.isUserInteractionEnabled = true
    }
    
    @objc func switchToSignUp() {
        loginContainer.isHidden = true
        loginContainer.isUserInteractionEnabled = false
        signUpContainer.isHidden = false
        signUpContainer.isUserInteractionEnabled = true
    }
    
    @objc func successfullySignedUp() {
        if (usernameTextField.hasText && (usernameTextField.text!.count < 4 || usernameTextField.text!.count > 16)) {
            let alertVC = UIAlertController(title: "Username not valid", message: "Your username has to be between 4-16 characters", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertVC.addAction(cancelAction)
            self.present(alertVC, animated: true, completion: nil)
        }
        else if (usernameTextField.hasText && passwordTextField.hasText && nameTextField.hasText && contactTextField.hasText) {
            networkSignup(username: usernameTextField.text!, password: passwordTextField.text!, name: nameTextField.text!, contact: contactTextField.text!)
            self.navigationController?.pushViewController(CustomTabBarController(), animated: true)
        }
        else {
            let alertVC = UIAlertController(title: "Error", message: "Make sure to fill in all the fields", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertVC.addAction(cancelAction)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @objc func checkLogin() {
        networkLogin(username: usernameTextField2.text!, password: passwordTextField2.text!)
    }
    
    func networkLogin(username: String, password: String) {
        NetworkManager.login(username: username, password: password) { response in
            self.session_token = response
            if self.session_token == "Invalid" {
                let alertVC = UIAlertController(title: "Error", message: "Invalid username/password", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertVC.addAction(cancelAction)
                self.present(alertVC, animated: true, completion: nil)
            }
            else {
                self.navigationController?.pushViewController(CustomTabBarController(), animated: true)
            }
        }
    }
    
    func networkSignup(username: String, password: String, name: String, contact: String) {
        NetworkManager.createUser(username: username, password: password, name: name, contact: contact) { response in
            self.currentUser = response
        }
    }
    
}
