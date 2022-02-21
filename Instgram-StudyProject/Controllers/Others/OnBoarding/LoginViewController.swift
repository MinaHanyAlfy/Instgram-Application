//
//  LoginViewController.swift
//  Instgram-StudyProject
//
//  Created by Mina Hanna on 06/02/2022.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    struct Const {
        static let cornerRadius:  CGFloat = 8.0
    }
    
    private let usernameEmaillField : UITextField = {
        let username = UITextField()
        username.placeholder = "Username or Email..."
        username.returnKeyType = .next
        username.leftViewMode = .always
        username.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        username.autocorrectionType = .no
        username.autocapitalizationType = .none
        username.layer.masksToBounds = true
        username.layer.borderColor =  UIColor.secondaryLabel.cgColor
        username.layer.cornerRadius = Const.cornerRadius
        username.backgroundColor = .secondarySystemBackground
        username.layer.borderWidth = 1.0
        return username
    }()
    
    private let passwordField: UITextField = {
        let password = UITextField()
        password.placeholder = "Password..."
        password.isSecureTextEntry = true
        password.returnKeyType = .next
        password.leftViewMode = .always
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        password.autocorrectionType = .no
        password.autocapitalizationType = .none
        password.layer.masksToBounds = true
        password.layer.cornerRadius = Const.cornerRadius
        password.backgroundColor = .secondarySystemBackground
        password.returnKeyType = .continue
        password.layer.borderColor =  UIColor.secondaryLabel.cgColor
        password.layer.borderWidth = 1.0
        return password
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Const.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("New User? Create an Account", for: .normal)
        button.setTitleColor(.label ,for: .normal)
        //        button.backgroundColor =
        return button
    }()
    
    private let headerView: UIView =  {
        let header = UIView()
        header.clipsToBounds = true
        let imageBackgroundView = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(imageBackgroundView)
        return header
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        usernameEmaillField.delegate = self
        passwordField.delegate = self
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        termsButton
            .addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //MARK: - assign frames
        
        configureForm()
        configurationHeaderView()
    }
    
    
    private func configureForm(){
        headerView.frame = CGRect(
            x: 0.0,
            y: 0.0,
            width:view.width,
            height: view.height / 3.0)
        
        usernameEmaillField.frame = CGRect(
            x: 25.0,
            y: headerView.bottom + 10,
            width: view.width - 50,
            height: 52.0)
        
        passwordField.frame = CGRect(
            x: 25.0,
            y: usernameEmaillField.bottom + 10,
            width: view.width - 50,
            height: 52.0)
        
        loginButton.frame = CGRect(
            x: 25.0,
            y: passwordField.bottom + 10,
            width: view.width - 50,
            height: 52.0)
        
        createAccountButton.frame = CGRect(
            x: 25.0,
            y: loginButton.bottom + 10,
            width: view.width - 50,
            height: 52.0
        )
        
        privacyButton.frame = CGRect(
            x: 25.0,
            y: view.height-view.safeAreaInsets.top - 50,
            width: view.width - 50,
            height: 52.0
        )
        
        termsButton.frame = CGRect(
            x: 25.0,
            y: view.height-view.safeAreaInsets.top - 10,
            width: view.width - 50,
            height: 52.0
        )
    }
    private func configurationHeaderView(){
        guard headerView.subviews.count == 1 else {
            return
        }
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        
        let logo = UIImageView(image: UIImage(named: "logo"))
        logo.frame = CGRect(x: headerView.width/4.0,
                            y: view.safeAreaInsets.top,
                            width: headerView.width/2.0,
                            height: headerView.height - view.safeAreaInsets.top )
        logo.contentMode = .scaleAspectFit
        backgroundView.addSubview(logo)
        //Add instgram header
    }
    
    
    //MARK: - addViews --
    private func addSubViews(){
        view.addSubview(usernameEmaillField)
        view.addSubview(passwordField)
        view.addSubview(headerView)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
    }
    
    //MARK: - Buttons Tapp
    @objc private func didTapLoginButton(){
        usernameEmaillField.resignFirstResponder()
        passwordField.resignFirstResponder()
        var username: String?
        var email: String?
        guard let usernameEmail = usernameEmaillField.text, !usernameEmail.isEmpty,
              let passowrd = passwordField.text, !passowrd.isEmpty, passowrd.count >= 8 else {
                  return
              }
        if usernameEmail.contains("@"),usernameEmail.contains("."){
            email = usernameEmail
        }else{
            username = usernameEmail
        }
        //Login functionality.
        AuthManager.shared.loginUser(username: username, password: passowrd, email: email) { success in
            DispatchQueue.main.async { [self] in
                print("Response: ",success)
                if success {
                    dismiss(animated: true, completion: nil)
                }else{
                    let alert =  UIAlertController(title: "Log in error", message: "We were enable to log in.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                    present(alert, animated: true, completion: nil  )
                }
            }
            
        }
        
        
    }
    @objc private func didTapTermsButton(){
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else{
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    @objc private func didTapPrivacyButton(){
        guard let url = URL(string: "https://help.instagram.com/155833707900388") else{
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    @objc private func didTapCreateAccountButton(){
        let vc = RegisterationViewController()
//        vc.modalPresentationStyle = .fullScreen
        vc.title = "Create Account"
        let navigationController = UINavigationController(rootViewController: vc)
        present(navigationController, animated: true, completion: nil)
        
    }
    
}
extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField  == usernameEmaillField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField{
            didTapLoginButton()
        }
        return true
    }
}
