//
//  HomeScreenViewController.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func brokerLoginButtonTapped(_ sender: Any) {
        // if user != broker {
        presentYoureNotABrokerAlertController()
        // }
    }
    
    func presentYoureNotABrokerAlertController() {
            UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor.AutoBlue
        let youreNotABrokerAlertController = UIAlertController(title: "If you are not a broker", message: "please select the login button", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        //changing color of alerController background
        let backView = youreNotABrokerAlertController.view.subviews.last
        backView?.layer.cornerRadius = 10.0
        backView?.backgroundColor = UIColor.white
        
        youreNotABrokerAlertController.addAction(dismissAction)
        present(youreNotABrokerAlertController, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}