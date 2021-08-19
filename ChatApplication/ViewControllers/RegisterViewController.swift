//
//  RegisterViewController.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/17/21.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var houseAddressTextField: UITextField!
    @IBOutlet weak var brgyTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var provinceTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    var completionHandler: ((String?) -> Void)?
    var addressFromMap: String!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        configureTextFields()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "segueToMapView" else {
            return
        }
//        let mapViewVC = segue.destination as! MapViewController
    }
    
    private func configureTextFields(){
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        cityTextField.delegate = self
        zipCodeTextField.delegate = self
        provinceTextField.delegate = self
        countryTextField.delegate = self
    }
    
    func setUpElements() {
        
        // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleTextField(houseAddressTextField)
        Utilities.styleTextField(brgyTextField)
        Utilities.styleTextField(cityTextField)
        Utilities.styleTextField(zipCodeTextField)
        Utilities.styleTextField(provinceTextField)
        Utilities.styleTextField(countryTextField)
        Utilities.styleTextField(confirmPasswordTextField)
        Utilities.styleFilledButton(registerButton)
    }
    
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            houseAddressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            brgyTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            provinceTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        // Check if the passwords matches
        if passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            
            return "Your password don't match."
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    @IBAction func didTappedButton() {
        
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        // Validate the fields first
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showError(message: "\(error!)")
        }
        else {
            
            // Create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let completeAddress = "\(houseAddressTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)), \(brgyTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)), \(cityTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)), \(provinceTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)), \(countryTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)), \(zipCodeTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))"
            
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                
                if error != nil {
                    
                    self.showError(message: error!.localizedDescription)
                }
                else {
                    // User was created successfully, now store the first name and last namer
                    // Need to  pod install the Firebase/Firestore
                    let db = Firestore.firestore()
                    //need of collection users in data base, add document with fields of "firstname", "lastname", and  "uid"
                    db.collection("users").addDocument(data: ["address": completeAddress, "first_name":firstName, "last_name":lastName, "user_id": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            self.showError(message: "Error saving user data")
                        }
                    }
                    // Segue to the home screen
                    self.segueToHomeVC()
                }
            }
        }
    }
    
    func showError(message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func segueToHomeVC() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
