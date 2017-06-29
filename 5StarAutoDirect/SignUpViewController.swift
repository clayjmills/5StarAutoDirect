//
//  SignUpViewController.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import UIKit
import FirebaseAuth
import KeychainSwift
import FirebaseDatabase
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIImageView!
    
    var isSignUp: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let keyChain = DatabaseManager().keyChain
        if keyChain.get("uid") != nil {
            performSegue(withIdentifier: "toUserHomeVC", sender: nil)
        }
    }
    
    func completeSignIn (id: String) {
        let keyChain = DatabaseManager().keyChain
        keyChain.set(id , forKey: "uid")
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, let phone = phoneTextField.text, let email = emailTextField.text, let password = passwordTextField.text else { return }
        // TODO: - add password field
        
        if isSignUp {
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                
                // This is my attempt to check if the user's email contains 5StarAuto, and then make them either a broker or not, based on that. If this doesn't work, delete lines 35-41 and uncomment 43 & 45
                
                let broker: Bool
                if email.uppercased().contains("5STARAUTO") {
                    broker = true
                } else {
                    broker = false
                }
                let user = User(name: name, phone: phone, email: email, isBroker: broker, messages: [], currentStep: .One)
                if user != nil {
                    self.completeSignIn(id: user.name)
                }
                
                //                if user == user {
                self.performSegue(withIdentifier: "signUpToCustomersVC", sender: self)
                //                }
            })
        } else {
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                if user != nil {
                    self.completeSignIn(id: user!.uid)
                    //User is found, go to home screen
                    self.performSegue(withIdentifier: "toUserHomeVC", sender: self)
                } else {
                    //Error: check error and show message
                }
            })
        }
        
    }
    
    @IBAction func SignOutButtonTapped(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        DatabaseManager().keyChain.delete("uid")
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signUpToCustomersVC" {
            
            let createdUser = BrokerTableViewController.shared.user
            if let detailVC = segue.destination as? BrokerTableViewController {
                detailVC.user = createdUser
            }
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
    }
}
