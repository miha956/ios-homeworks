//
//  PostModel.swift
//  Navigation
//
//  Created by Миша Вашкевич on 06.12.2023.
//

import Foundation
import UIKit

struct Post {
    let author: String
    var description: String
    var image: UIImage?
    var likes: Int
    var views: Int
}

extension Post {
    
    static func make() -> [Post] {
        [ 
            Post(
            author: "Justin",
            description: "ahaha it's so funny",
            image: UIImage(named: "gag"),
            likes: 99,
            views: 109),
            Post(
            author: "Michael",
            description: "nature",
            image: UIImage(named: "nature"),
            likes: 66,
            views: 101),
          Post(
            author: "SpaceX",
            description: "let's go to stars",
            image: UIImage(named: "elon"),
            likes: 31,
            views: 34),
          Post(
            author: "Discovery",
            description: "hurry up, today a new episode with BearGrils, 10 ap at Discovert channel",
            image: UIImage(named: "discovery"),
            likes: 13,
            views: 78)
        ]
    }
}
