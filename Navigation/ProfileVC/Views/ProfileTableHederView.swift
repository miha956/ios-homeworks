//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Миша Вашкевич on 28.11.2023.
//

import Foundation
import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Subviews
    
    lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.image = UIImage(named: "cat")
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.clipsToBounds = true
        let avatarTap = UITapGestureRecognizer(
            target: self,
            action: #selector(avatarOpened))
        avatarTap.numberOfTapsRequired = 1
        avatarImageView.addGestureRecognizer(avatarTap)
        avatarImageView.isUserInteractionEnabled = true
        return avatarImageView
    }()
    let fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.text = "Hipster Cat"
        fullNameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        fullNameLabel.textColor = .black
        return fullNameLabel
    }()
    let statusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.placeholder = "Write status"
        statusTextField.textColor = .black
        statusTextField.font = .systemFont(ofSize: 15, weight: .regular)
        statusTextField.backgroundColor = .white
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = CGColor(red: 0/255,
                                                      green: 0/255,
                                                      blue: 0/255,
                                                      alpha: 1)
        statusTextField.layer.cornerRadius = 12
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        statusTextField.leftViewMode = .always
        statusTextField.leftView = spacerView
        statusTextField.addTarget(nil, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        return statusTextField
    }()
    let setStatusButton: UIButton = {
        let setStatusButton = UIButton(type: .system)
        setStatusButton.translatesAutoresizingMaskIntoConstraints = false
        setStatusButton.setTitle("Show status", for: .normal)
        setStatusButton.setTitleColor(.white, for: .normal)
        setStatusButton.backgroundColor = .systemBlue
        setStatusButton.layer.shadowOffset = CGSize(
                                            width: 4,
                                            height: 4)
        setStatusButton.layer.shadowColor = CGColor(
                                            red: 0/255,
                                            green: 0/255,
                                            blue: 0/255,
                                            alpha: 1)
        setStatusButton.layer.shadowOpacity = 0.7
        setStatusButton.addTarget(nil, action: #selector(buttonPressed), for: .touchUpInside)
        return setStatusButton
    }()
    var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "Waiting for something..."
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.font = .systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = .gray
        return statusLabel
    }()
    private lazy var backView: UIView = {
        let backView = UIView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: UIScreen.main.bounds.width,
                                            height: UIScreen.main.bounds.height))
        backView.backgroundColor = .white
        backView.alpha = 0
        return backView
    }()
    private lazy var closeAvatarButton: UIButton = {
        let closeAvatarButton = UIButton(type: .system)
        closeAvatarButton.translatesAutoresizingMaskIntoConstraints = false
        closeAvatarButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeAvatarButton.tintColor = .black
        closeAvatarButton.alpha = 0
        closeAvatarButton.addTarget(self, action: #selector(avatarClosed), for: .touchUpInside)
        return closeAvatarButton
    }()

    // MARK: - Lifecycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        setStatusButton.layer.cornerRadius = 10
    }
    
    // MARK: - Actions
    
    @objc func buttonPressed() {
        //print(statusLabel.text)
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        statusLabel.text = text
    }
    
    @objc func avatarOpened(target: UIView) {
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.post(name: Notification.Name("avatarOpened"), object: nil)
        
        UIView.animate(
            withDuration: 0.1,
                    delay: 0,
                    options: .curveLinear
                ) {
                    self.backView.alpha = 1
            }
        UIView.animate(
            withDuration: 0.5,
                    delay: 0.3,
                    options: .curveLinear
                ) {
                    self.closeAvatarButton.alpha = 1
            }
    }
    
    @objc func avatarClosed() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.post(name: Notification.Name("avatarClosed"), object: nil)
        UIView.animate(
            withDuration: 0.1,
            delay: 0.0,
                    options: .curveLinear
                ) {
                    self.closeAvatarButton.alpha = 0
            }
        UIView.animate(
            withDuration: 0.1,
                    delay: 0,
                    options: .curveLinear
                ) {
                    self.backView.alpha = 0
            }
    }
    
    // MARK: - Private
    
    private func addSubviews() {
        
        self.addSubview(avatarImageView)
        self.addSubview(fullNameLabel)
        self.addSubview(statusLabel)
        self.addSubview(setStatusButton)
        self.addSubview(statusTextField)
        self.addSubview(backView)
        self.sendSubviewToBack(backView)
        self.addSubview(closeAvatarButton)
    }
    
    private func setupConstraints() {
        
        let safeAreaLayoutGuide = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo:self.safeAreaLayoutGuide.topAnchor,constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo:self.leadingAnchor,constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
        
            fullNameLabel.topAnchor.constraint(equalTo:self.safeAreaLayoutGuide.topAnchor,constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo:avatarImageView.trailingAnchor,constant: 25),
            setStatusButton.topAnchor.constraint(equalTo:avatarImageView.bottomAnchor,constant: 37),
            setStatusButton.trailingAnchor.constraint(equalTo:self.trailingAnchor,constant: -16),
            setStatusButton.leadingAnchor.constraint(equalTo:self.leadingAnchor,constant: 16),
            setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            statusLabel.bottomAnchor.constraint(equalTo:setStatusButton.topAnchor,constant: -55),
            statusLabel.leadingAnchor.constraint(equalTo:avatarImageView.trailingAnchor,constant: 25),
            
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 5),
            statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 25),
            statusTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            closeAvatarButton.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20),
            closeAvatarButton.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20)
            
            
        ])
    }
}
