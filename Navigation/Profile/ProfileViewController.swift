//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Миша Вашкевич on 28.11.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileHeaderView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileHeaderView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        view.addSubview(profileHeaderView)
    }
    

    
    // MARK: - Navigation

    func setView() {
        title = "Profile"
        view.backgroundColor = .lightGray
        
    }

}
