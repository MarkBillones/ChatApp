//
//  SettingsViewController.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/25/21.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let icon4 = UITabBarItem(title: "Settings", image: .init(systemName: "gearshape"), selectedImage: .init(systemName: "gearshape.fill"))
        
        self.tabBarItem = icon4
        
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
