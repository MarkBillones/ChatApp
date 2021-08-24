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
        delegate = self
        
        guard
            let home = storyboard?.instantiateViewController(identifier: "HomeNavigationVC")
        else { return}
        
        let controllers = [home]  //array of the root view controllers displayed by the tab bar interface
        self.viewControllers = controllers
        
    }
    
    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }

}
