//
//  SettingsViewController.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/25/21.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        
        let auth = Auth.auth()
        
        do
        {
            try auth.signOut()
            let mainViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.rootNavigationController) //as? HomeViewController

            self.view.window?.rootViewController = mainViewController
            self.view.window?.makeKeyAndVisible()
            
        }
        catch {
            print("error in Logout")
        }
    }
    
}
