//
//  YourCarViewController.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import UIKit
import Firebase

class UserHomeViewController: UIViewController {
    @IBAction func messagebuttonTapped(_ sender: Any) {
        navigationController?.pushViewController(MessageDetailViewController(), animated: true)
    }
    
    static let shared = UserHomeViewController()
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userHomeVCToMessagesTVC" {
            let selectedUser = UserHomeViewController.shared.user
            if let detailVC = segue.destination as? MessagesTableViewController {
                detailVC.user = selectedUser
            }
        }
    }    
}
