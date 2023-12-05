//
//  LogInViewController.swift
//  Navigation
//
//  Created by Миша Вашкевич on 04.12.2023.
//

import UIKit

class LogInViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .yellow
        return contentView
    }()
    private lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logo")
        return logoImageView
    }()
    private lazy var loginTextField: UITextField = {
        let loginTextField = UITextField()
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.borderStyle = UITextField.BorderStyle.roundedRect
        loginTextField.backgroundColor = .gray
        loginTextField.placeholder = "Email or phone"
        return loginTextField
    }()
    private lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.backgroundColor = .gray
        passwordTextField.placeholder = "Password"
        return passwordTextField
    }()
    private lazy var logInStackview: UIStackView = {
        let logInStackview = UIStackView()
        logInStackview.translatesAutoresizingMaskIntoConstraints = false
        logInStackview.axis = .vertical
        return logInStackview
    }()
    private lazy var logInButton: UIButton = {
        let logInButton = UIButton()
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        return logInButton
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        addSubviews()
        setupConstraints()
    }


    // MARK: - private
    
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
    }
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logoImageView)
        logInStackview.addArrangedSubview(loginTextField)
        logInStackview.addArrangedSubview(passwordTextField)
        contentView.addSubview(logInStackview)
        contentView.addSubview(logInButton)
        
        setupContentOfScrollView()
    }
    private func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            logInStackview.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            logInStackview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInStackview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInStackview.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.topAnchor.constraint(equalTo: logInStackview.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 200)
            
        ])
        
    }
    private func setupContentOfScrollView() {
   
    }


}
