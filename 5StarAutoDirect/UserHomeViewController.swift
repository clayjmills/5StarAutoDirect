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
    
    static let shared = UserHomeViewController()
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
        }
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
    try! Auth.auth().signOut()
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userHomeVCToMessageConvoVC" {
            
            self.fetchMessages(completion: { (messages) in
                self.user?.messages = messages
            })
            
            let selectedUser = UserHomeViewController.shared.user
            if let detailVC = segue.destination as? MessageConvoViewController {
                detailVC.user /*or maybe .customer*/ = selectedUser
            }
            
        } else {
            if segue.identifier == "toCarDetail" {
                let selectedUser = CarDetailViewController.shared.user
                if let detailVC = segue.destination as? CarDetailViewController {
                    detailVC.user = selectedUser
                }
            }
        }
    }
    
    func fetchMessages(completion: @escaping([Message]) -> Void) {
        MessageController.shared.fetchMessages { (messages) in
            guard let messages = messages else { return }
            completion(messages)
        }
    }
}
