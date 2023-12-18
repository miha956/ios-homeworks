//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Миша Вашкевич on 28.11.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Data
    
    fileprivate let data = Post.make()
    fileprivate let userData = User.make()
    
    // MARK: - Subviews
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private lazy var initialAvatarOrigin = CGPoint()
    private lazy var initialAvatarFrame = CGRect()
    
    private enum CellReuseID: String {
            case postCell = "PostTableViewCell_ReuseID"
            case photosCell = "PhotosTableViewCell_ReuseID"
        }
    private enum HeaderFooterReuseID: String {
            case base = "ProfileTableHederView_ReuseID"
        }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        tuneTableView()
        setupConstraints()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(avatarTapOpenAction),
            name: Notification.Name("avatarOpened"),
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(avatarTapCloseAction),
            name: Notification.Name("avatarClosed"),
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Actions
    
    @objc func avatarTapOpenAction() {
        
        guard let profileView = self.tableView.headerView(forSection: 0) as? ProfileHeaderView else {return}
        let avatarImageView = profileView.avatarImageView
        initialAvatarOrigin = avatarImageView.center
        initialAvatarFrame = avatarImageView.frame
        
        UIView.animateKeyframes(withDuration: 0.5,
                                delay: 0.1,
                                options: .calculationModeCubic,
                                animations: {
            UIView.addKeyframe(
                withRelativeStartTime: 0.0,
                relativeDuration: 0.1) {
                    profileView.fullNameLabel.alpha = 0
                    profileView.setStatusButton.alpha = 0
                    profileView.statusLabel.alpha = 0
                    profileView.statusTextField.alpha = 0
                    self.tabBarController?.tabBar.isHidden = true
                    self.view.backgroundColor = .white
                }
            UIView.addKeyframe(
                withRelativeStartTime: 0.1,
                relativeDuration: 1
            ) {
                avatarImageView.layer.borderWidth = 0
                avatarImageView.layer.borderColor = UIColor.clear.cgColor
                avatarImageView.layer.cornerRadius = 0
                avatarImageView.clipsToBounds = false
                //avatarImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width) // не работает, картинка возвращается обратно
                let width = UIScreen.main.bounds.width/avatarImageView.frame.width
                avatarImageView.transform = CGAffineTransform(
                    scaleX: width,
                    y: width
                )
                avatarImageView.center = CGPoint(
                    x: self.view.bounds.midX,
                    y: self.view.bounds.midY - (self.tabBarController?.tabBar.frame.height)!
                )
            }
        },
                                completion: { state in
            print("avatar aniimation finish")
        })
    }

    @objc func avatarTapCloseAction() {
        
        guard let profileView = self.tableView.headerView(forSection: 0) as? ProfileHeaderView else {return}
        let avatarImageView = profileView.avatarImageView
        
        UIView.animateKeyframes(withDuration: 0.2,
                                delay: 0.1,
                                options: .calculationModeLinear,
                                animations: {
            UIView.addKeyframe(
                withRelativeStartTime: 0.0,
                relativeDuration: 0.1) { [self] in
                    profileView.fullNameLabel.alpha = 1
                    profileView.setStatusButton.alpha = 1
                    profileView.statusLabel.alpha = 1
                    profileView.statusTextField.alpha = 1
                    self.tabBarController?.tabBar.isHidden = false
                    self.view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
                    avatarImageView.layer.borderWidth = 3
                    avatarImageView.layer.borderColor = UIColor.white.cgColor
                    avatarImageView.clipsToBounds = true
                    avatarImageView.center = initialAvatarOrigin
                    let width = UIScreen.main.bounds.width/avatarImageView.frame.width
                    avatarImageView.transform = CGAffineTransform(
                        scaleX: width,
                        y: width
                    )

            
                }
        },
            completion: { state in
            print("avatar aniimation finish")
        })
    }
    
    // MARK: - private
    
    private func setupView() {
         view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
     }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
}

    // MARK: - tableView

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func tuneTableView() {
        
        tableView.allowsSelection = true
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.postCell.rawValue
                )
        tableView.register(
            PhotosTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.photosCell.rawValue
                )
        tableView.register(
            ProfileHeaderView.self,
            forHeaderFooterViewReuseIdentifier: HeaderFooterReuseID.base.rawValue
        )
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: HeaderFooterReuseID.base.rawValue) as? 
            ProfileHeaderView else {
            fatalError("could not dequeueReusableCell")
            
        }
        if section == 0 {
            return headerView
        } else {
            return nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return data.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let postCell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.postCell.rawValue,
                for: indexPath) as? PostTableViewCell else {
                fatalError("could not dequeueReusableCell")
        }
        guard let photosCell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.photosCell.rawValue,
                for: indexPath) as? PhotosTableViewCell else {
                fatalError("could not dequeueReusableCell")
        }
        postCell.update(data[indexPath.row])
        photosCell.updateData(photos: userData.photos)
        
        switch indexPath.section {
        case 0:
            return photosCell
        case 1:
            return postCell
        default:
            return UITableViewCell(style: .default, reuseIdentifier: "base")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = PhotosViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
