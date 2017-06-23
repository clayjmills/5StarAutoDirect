//
//  SignUpViewController.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var submitButton: UIImageView!
    
    var isSignIn: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, let phone = phoneTextField.text, let email = emailTextField.text else { return }
        
        if isSignIn {
            
        }
        
        UserController.shared.createUser(name: name, phone: phone, email: email, isBroker: false /* <- just for committing purposes*/ )
    }
    
}
