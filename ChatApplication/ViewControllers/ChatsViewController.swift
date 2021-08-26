//
//  ChatViewController.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/25/21.
//

import UIKit

class ChatsViewController: UIViewController {
    
    @IBOutlet weak var chatsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatsTableView.delegate = self
        chatsTableView.dataSource = self
    }
    
}

extension ChatsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Mark Allen"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //show here the chat messages
        let vc = ConversationViewController()
        vc.title = "Messages"
        navigationController?.pushViewController(vc, animated: true)
    }
}
