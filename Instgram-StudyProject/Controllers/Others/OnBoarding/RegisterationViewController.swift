//
//  RegisterationViewController.swift
//  Instgram-StudyProject
//
//  Created by Mina Hanna on 06/02/2022.
//

import UIKit

class RegisterationViewController: UIViewController {
    struct Const {
        static let cornerRadius:  CGFloat = 8.0
    }
    private let usernameField : UITextField = {
        let username = UITextField()
        username.placeholder = "Usernames..."
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
    
    private let emailField : UITextField = {
        let username = UITextField()
        username.placeholder = "Email..."
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
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign UP", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Const.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.addTarget(self, action: #selector(didTaSignUpButton), for: .touchUpInside)
        formViews()
        
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        handleFormViews()
       
    }
   
    private func formViews(){
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        usernameField.delegate = self
        emailField.delegate = self
        passwordField    .delegate = self
    }
    private func handleFormViews(){
        usernameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 10, width: view.width-40, height: 52)
        emailField.frame = CGRect(x: 20, y:usernameField.bottom + 10, width: view.width-40, height: 52)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom + 10, width: view.width-40, height: 52)
        registerButton.frame = CGRect(x: 20, y:passwordField.bottom + 10, width: view.width-40, height: 52)
    }
    //MARK: - Buttons Tapp
    @objc private func didTaSignUpButton(){
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
//        var username: String? 
//        var email: String?
        guard let username = usernameField.text, !username.isEmpty,
              let email = emailField.text,!email.isEmpty,
              let passowrd = passwordField.text, !passowrd.isEmpty, passowrd.count >= 8 else {
                  return
              }
        //Login functionality.
      
        AuthManager.shared.registerNewUser(username: username, password: passowrd, email: email) { success in
            DispatchQueue.main.async {
                if success {
                    
                }else {
                    let alert =  UIAlertController(title: "Register error", message: "We were enable to sign up .", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                    self.present(alert, animated: true, completion: nil  )
                }
            }
            
        }
    }
}
extension RegisterationViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField  == usernameField {
            passwordField.becomeFirstResponder()
        }
        else if textField == emailField{
            emailField.becomeFirstResponder()
        }
        else if textField == passwordField{
            didTaSignUpButton()
        }
        return true
    }
}
