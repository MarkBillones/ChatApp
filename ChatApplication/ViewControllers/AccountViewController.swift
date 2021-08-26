//
//  SettingsViewController.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/25/21.
//

import UIKit
import Firebase
import FirebaseAuth

enum ProfileViewModelType {
    case info, logout
}

struct ProfileViewModel {
    let viewModelType: ProfileViewModelType
    let title: String
    let handler: (() -> Void)?
}

final class AccountViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = [ProfileViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        
        data.append(ProfileViewModel(viewModelType: .info,
                                     title: "Name: \(UserDefaults.standard.value(forKey:"name") as? String ?? "Mark Allen Billones")",
                                     handler: nil))
        data.append(ProfileViewModel(viewModelType: .info,
                                     title: "Email: \(UserDefaults.standard.value(forKey:"email") as? String ?? "No Email")",
                                     handler: nil))
        data.append(ProfileViewModel(viewModelType: .logout, title: "Log Out", handler: { [weak self] in
            
            guard let strongSelf = self else {
                return
            }
            
            let actionSheet = UIAlertController(title: "",
                                                message: "",
                                                preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Log Out",
                                                style: .destructive,
                                                handler: { [weak self] _ in
                                                    
                                                    //UserDefaults.standard.setValue(nil, forKey: "email")
                                                    //UserDefaults.standard.setValue(nil, forKey: "name")
                                                    
                                                    do {
                                                        
                                                        try FirebaseAuth.Auth.auth().signOut()
                                                        
                                                        let mainViewController = self?.storyboard?.instantiateViewController(identifier: Constants.Storyboard.rootNavigationController) //as? HomeViewController
                                                        
                                                        self!.view.window?.rootViewController = mainViewController
                                                        self!.view.window?.makeKeyAndVisible()
                                                    }
                                                    catch {
                                                        print("Failed to log out")
                                                    }
                                                    
                                                }))
            
            actionSheet.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))
            
            strongSelf.present(actionSheet, animated: true)
        }))
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier,
                                                 for: indexPath) as! ProfileTableViewCell
        cell.setUp(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.row].handler?()
    }
}

class ProfileTableViewCell: UITableViewCell {
    
    static let identifier = "ProfileTableViewCell"
    
    public func setUp(with viewModel: ProfileViewModel) {
        self.textLabel?.text = viewModel.title
        switch viewModel.viewModelType {
        case .info:
            textLabel?.textAlignment = .left
            selectionStyle = .none
        case .logout:
            textLabel?.textColor = .red
            textLabel?.textAlignment = .center
        }
    }
    
}

//let auth = Auth.auth()
//
//do {
//    try auth.signOut()
//    let mainViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.rootNavigationController) //as? HomeViewController
//
//    self.view.window?.rootViewController = mainViewController
//    self.view.window?.makeKeyAndVisible()
//
//}
//catch {
//    print("error in Logout")
//}
