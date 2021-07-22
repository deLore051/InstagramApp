//
//  LoginViewController.swift
//  InstagramApp
//
//  Created by Stefan Dojcinovic on 22.7.21..
//

import UIKit

class LoginViewController: UIViewController {

    private let usernameEmailTextField: UITextField = {
        return UITextField()
    }()
    
    private let passwordFieldTextField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton: UIButton = {
        return UIButton()
    }()
    
    private let termsButton: UIButton = {
        return UIButton()
    }()
    
    private let privacyButton: UIButton = {
        return UIButton()
    }()
    
    private let createAccountButton: UIButton = {
        return UIButton()
    }()
    
    private let headerView: UIView = {
        return UIView()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Assign frames
    }
    
    private func addSubviews() {
        view.addSubview(usernameEmailTextField)
        view.addSubview(passwordFieldTextField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
    }
    
    @objc private func didTapLoginButton() {}
    @objc private func didTapTermButton() {}
    @objc private func didTapPrivacyButton() {}
    @objc private func didTapCreateAccountButton() {}
    
}
