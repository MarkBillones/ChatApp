//
//  MapsViewController.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/25/21.
//

import UIKit

class MapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let icon3 = UITabBarItem(title: "Chats", image: .init(systemName: "map"), selectedImage: .init(systemName: "map.fill"))
        
        self.tabBarItem = icon3

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
