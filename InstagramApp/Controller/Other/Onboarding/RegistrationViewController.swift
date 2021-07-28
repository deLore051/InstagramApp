//
//  RegistrationViewController.swift
//  InstagramApp
//
//  Created by Stefan Dojcinovic on 22.7.21..
//

import UIKit

class RegistrationViewController: UIViewController {

    struct Constants {
        static let cornerRadius: CGFloat = 10.0
        static let textFieldHeight: CGFloat = 50.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordFieldTextField.delegate = self
        
        view.addSubview(usernameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordFieldTextField)
        view.addSubview(registerButton)
        
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        usernameTextField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 100,
                                         width: view.width - 40, height: Constants.textFieldHeight)
        
        emailTextField.frame = CGRect(x: 20, y: usernameTextField.bottom + 10,
                                         width: view.width - 40, height: Constants.textFieldHeight)
        
        passwordFieldTextField.frame = CGRect(x: 20, y: emailTextField.bottom + 10,
                                         width: view.width - 40, height: Constants.textFieldHeight)
        
        registerButton.frame = CGRect(x: 20, y: passwordFieldTextField.bottom + 20,
                                         width: view.width - 40, height: Constants.textFieldHeight)
    }
    
    private let usernameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0 ))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let emailTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0 ))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordFieldTextField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password..."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0 ))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()
  
    @objc func didTapRegisterButton() {
        usernameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordFieldTextField.resignFirstResponder()
        
        guard let email = emailTextField.text, !email.isEmpty,
              let username = usernameTextField.text, !username.isEmpty,
              let password = passwordFieldTextField.text, !password.isEmpty, password.count >= 8 else { return }
        
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registered in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if registered {
                    // Good to go
                } else {
                    // Failed
                }
            }
            
            
        }
        
    }
    
}


extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordFieldTextField.becomeFirstResponder()
        } else {
            didTapRegisterButton()
        }
        return true
    }
    
}
