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

class BrokerTableViewController: UITableViewController {
    
    static let shared = BrokerTableViewController()
    
    var user: User?
    var users: [User] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        tableView.dataSource = self
        tableView.delegate = self
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number of rows found \(UserController.shared.users.count) users")
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserInfoTableViewCell else { return UITableViewCell() }

        let user = users[indexPath.row]
        
        cell.user = user
        
        return cell
    }
//    func usersWereUpdatedTo(users: [User], on controller: UserController) {
//        tableView.reloadData()
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userCellToMessageVC" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedUser = self.users[indexPath.row]
                if let detailVC = segue.destination as? MessageConvoViewController {
                    detailVC.user = selectedUser
                }
            }
        }
    }
}
