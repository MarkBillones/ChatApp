//
//  ViewController.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/17/21.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    
    func setUpElements() {
        Utilities.styleFilledButton(registerButton)
        Utilities.styleHollowButton(loginButton)
        
    }

    @IBAction func registerButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
    }
    
}

