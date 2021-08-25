//
//  ChatViewController.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/25/21.
//

import UIKit

class ChatsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let icon2 = UITabBarItem(title: "Chats", image: .init(systemName: "message"), selectedImage: .init(systemName: "message.fill"))
        
        self.tabBarItem = icon2
    }
    

}
