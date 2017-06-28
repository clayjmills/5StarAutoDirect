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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            let userVC = UserHomeViewController()
            self.present(userVC, animated: true, completion: nil)
        }
    }

    var user: User?
    
    @IBAction func brokerButtonTapped(_ sender: Any) {
// We'll only need this if we decide to have the brokers got to this VC and tap the button to segue into the customer list
        
//        guard let user = user else { return }
//        if user.isBroker {
//            self.performSegue(withIdentifier: "toCustomerTVC", sender: self)
//        } else if user.isBroker == false {
//            presentYouCantGoThereAlert()
//        }
    }
    
//    func presentYouCantGoThereAlert() {
//        let accessDeniedAlertCont = UIAlertController(title: "You can't go there", message: nil, preferredStyle: .alert)
//        let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//        accessDeniedAlertCont.addAction(dismissAction)
//        present(accessDeniedAlertCont, animated: true, completion: nil)
//    }

}
