//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Миша Вашкевич on 28.11.2023.
//

import Foundation
import UIKit

class ProfileHeaderView: UIView {
    
    let avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.image = UIImage(named: "cat")
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = CGColor(red: 255/255,
                                                 green: 255/255,
                                                 blue: 255/255,
                                                 alpha: 1)
        avatarImageView.clipsToBounds = true
        //profileImage.frame = CGRect(x: 16, y: 0, width: 100, height: 100)
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
        statusTextField.placeholder = "Waiting for something..."
        statusTextField.font = .systemFont(ofSize: 14, weight: .regular)
        statusTextField.textColor = .white
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
        return setStatusButton
    }()
    private var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = ""
        statusLabel.isHidden = true
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(avatarImageView)
        self.addSubview(fullNameLabel)
        self.addSubview(statusTextField)
        self.addSubview(setStatusButton)
        self.addSubview(statusLabel)
        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        statusTextField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        
        setuoConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        setStatusButton.layer.cornerRadius = 10
    }
    
    private func setuoConstraints() {
        
        let safeAreaLayoutGuide = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: 
                                            self.safeAreaLayoutGuide.topAnchor,
                                            constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: 
                                            self.leadingAnchor,
                                            constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
        
            fullNameLabel.topAnchor.constraint(equalTo: 
                                            self.safeAreaLayoutGuide.topAnchor,
                                            constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo:
                                            avatarImageView.trailingAnchor,
                                            constant: 25),
            setStatusButton.topAnchor.constraint(equalTo:
                                            avatarImageView.bottomAnchor,
                                            constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo:
                                            self.trailingAnchor,
                                            constant: -16),
            setStatusButton.leadingAnchor.constraint(equalTo: 
                                            self.leadingAnchor,
                                            constant: 16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            statusTextField.bottomAnchor.constraint(equalTo:
                                            setStatusButton.topAnchor,
                                            constant: -34),
            statusTextField.leadingAnchor.constraint(equalTo:
                                            avatarImageView.trailingAnchor,
                                            constant: 25),
            statusLabel.topAnchor.constraint(equalTo: setStatusButton.bottomAnchor, constant: 20),
            statusLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    @objc func buttonPressed() {
        print(statusLabel.text)
        statusLabel.isHidden = false
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        statusLabel.text = text
    }
}
