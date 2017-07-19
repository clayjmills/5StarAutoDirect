//
//  BrokerTableViewController.swift
//  5StarAutoDirect
//
//  Created by Alex Whitlock on 6/15/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import UIKit
import Firebase

class BrokerTableViewController: UITableViewController, UserControllerDelegate {
    
    static let shared = BrokerTableViewController()
    
    var user: User?
    
    var users: [User] = [] {
        didSet{
            DispatchQueue.main.async {
                self.fetchUserList()
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserList()
        tableView.reloadData()
    }
    
    func usersWereUpdatedTo(users: [User], on controller: UserController) {
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserController.shared.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)

        let user = UserController.shared.users[indexPath.row]
        cell.textLabel?.text = user.name
        
        return cell
    }

    func fetchUserList() {
        UserController.fetchUsers { (users) in
            self.users = users
        }
    }
}
