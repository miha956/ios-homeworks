//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Миша Вашкевич on 28.11.2023.
//

import Foundation
import UIKit

class ProfileHeaderView: UIView {
    
    let profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.image = UIImage(named: "cat")
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.borderWidth = 3
        profileImage.layer.borderColor = CGColor(red: 255/255,
                                                 green: 255/255,
                                                 blue: 255/255,
                                                 alpha: 1)
        profileImage.clipsToBounds = true
        //profileImage.frame = CGRect(x: 16, y: 0, width: 100, height: 100)
        return profileImage
    }()
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Hipster Cat"
        nameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        nameLabel.textColor = .black
        return nameLabel
    }()
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Waiting for something..."
        textField.font = .systemFont(ofSize: 14, weight: .regular)
        textField.textColor = .white
        return textField
    }()
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowColor = CGColor(red: 0/255,
                                           green: 0/255,
                                           blue: 0/255,
                                           alpha: 1)
        button.layer.shadowOpacity = 0.7
        return button
    }()
    private var statusText: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        button.layer.cornerRadius = 10
    }
    
    private func setView() {
        self.addSubview(profileImage)
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: 
                                            self.safeAreaLayoutGuide.topAnchor,
                                            constant: 16),
            profileImage.leadingAnchor.constraint(equalTo: 
                                            self.leadingAnchor,
                                            constant: 16),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalToConstant: 100)
        ])
        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: 
                                            self.safeAreaLayoutGuide.topAnchor,
                                            constant: 27),
            nameLabel.leadingAnchor.constraint(equalTo:
                                            profileImage.trailingAnchor,
                                            constant: 25)
        ])
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        self.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo:
                                            profileImage.bottomAnchor,
                                            constant: 16),
            button.trailingAnchor.constraint(equalTo:
                                            self.trailingAnchor,
                                            constant: -16),
            button.leadingAnchor.constraint(equalTo: 
                                            self.leadingAnchor,
                                            constant: 16),
            button.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        textField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        self.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.bottomAnchor.constraint(equalTo:
                                            button.topAnchor,
                                            constant: -34),
            textField.leadingAnchor.constraint(equalTo:
                                            profileImage.trailingAnchor,
                                            constant: 25)
        ])
    }
    
    @objc func buttonPressed() {
        print(statusText)
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        statusText = text
    }
}
