//
//  ViewController.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/23/21.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.backgroundColor = UIColor.white.cgColor
        tabBar.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
        delegate = self
        
        guard
            let home = storyboard?.instantiateViewController(identifier: "HomeNavigationVC"),
            let chats = storyboard?.instantiateViewController(identifier: "ChatsNavigationVC"),
            let maps = storyboard?.instantiateViewController(identifier: "MapsNavigationVC"),
            let accounts = storyboard?.instantiateViewController(identifier: "AccountNavigationVC")
        else { return}
        
        home.title = "Meals"
        chats.title = "Chats"
        maps.title = "Maps"
        accounts.title = "Account"
        
        chats.tabBarItem.image = UIImage(systemName: "message")
        maps.tabBarItem.image = UIImage(systemName: "map")
        accounts.tabBarItem.image = UIImage(systemName: "person.circle")
        chats.tabBarItem.selectedImage = UIImage(systemName: "message.fill")
        maps.tabBarItem.selectedImage = UIImage(systemName: "map.fill")
        accounts.tabBarItem.selectedImage = UIImage(systemName: "person.circle.fill")
        
        self.setViewControllers([home, chats, maps, accounts], animated: false) //array of the root view controllers displayed by the tab bar interface
        
    }
    
    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
    
}
