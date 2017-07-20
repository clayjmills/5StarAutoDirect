//
//  BrokerTableViewController.swift
//  5StarAutoDirect
//
//  Created by Alex Whitlock on 6/15/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class BrokerTableViewController: UITableViewController, UserControllerDelegate {
    
    static let shared = BrokerTableViewController()
    
    var user: User?
    
    var users: [User] = [] {
        didSet{
//            DispatchQueue.main.async {
//                // self.fetchUserList()
//                self.tableView.reloadData()
//            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserList()
        tableView.reloadData()
    }
    
    // getting users from firebase to broker TVC
    func fetchUser() {
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User(jsonDictionary: dictionary, identifier: "user")
                //user.setValuesForKeysWithDictionary(dictionary)
                self.users.append(user!)
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
                
                print(user?.name, user?.email)
            }
        }, withCancel: nil)
    }
    
    
    
    func usersWereUpdatedTo(users: [User], on controller: UserController) {
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return UserController.shared.users.count
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "userCell")
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        
        //        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserInfoTableViewCell else { return UITableViewCell() }
        //
        //        let user = UserController.shared.users[indexPath.row]
        //        cell.user = user
        
        return cell
    }
    
    func fetchUserList() {
        UserController.fetchUsers { (users) in
            self.users = users
        }
    }
}
