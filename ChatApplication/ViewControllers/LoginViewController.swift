//
//  LoginViewController.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/17/21.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginBottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        configureTextfield()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    private func configureTextfield(){
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    func setUpElements() {
        
        // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.whiteStyleHollowButton(loginButton)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let info = notification.userInfo {
            
            let rect:CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.view.layoutIfNeeded()
                self.loginBottomConstraints.constant = rect.height - 20
                
            })
        }
        
        
    }
    
    private func showMissingEmailAlert() {
        let alertController = UIAlertController(
            title: "Email Required",
            message: "Please enter a your email.",
            preferredStyle: .alert)
        
        let action = UIAlertAction(
            title: "Okay",
            style: .default) { _ in
            self.emailTextField.becomeFirstResponder()
        }
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        
        // Create cleaned versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard
          let defaultEmail = emailTextField.text,
          !defaultEmail.isEmpty
        else {
          showMissingEmailAlert()
          return
        }
        
        emailTextField.resignFirstResponder()
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            
            if error != nil {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                
                UserDefaults.standard.set(email, forKey: "email")
                // programmatically  segue to home
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarController) //as? HomeViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
                
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.view.layoutIfNeeded()
            self.loginBottomConstraints.constant = 40
            
        })
    }
}

