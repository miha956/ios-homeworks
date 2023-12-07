//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Миша Вашкевич on 28.11.2023.
//

import Foundation
import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
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
    private var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "Waiting for something..."
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.font = .systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = .gray
        return statusLabel
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addSubview(avatarImageView)
        self.addSubview(fullNameLabel)
        self.addSubview(statusLabel)
        self.addSubview(setStatusButton)
        self.addSubview(statusTextField)
        
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
            statusTextField.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    @objc func buttonPressed() {
        //print(statusLabel.text)

    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        statusLabel.text = text
    }
}
