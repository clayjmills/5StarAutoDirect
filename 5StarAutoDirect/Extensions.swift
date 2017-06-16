//
//  Extensions.swift
//  5StarAutoDirect
//
//  Created by Alex Whitlock on 6/15/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    // if this isn't working, these may need to be out of a percentage of 255
    static let AutoBlue = UIColor.init(red: 0, green: 39, blue: 108, alpha: 100)
    static let AutoRed = UIColor.init(red: 202, green: 19, blue: 6, alpha: 100)
}

class NotAViewController: UIViewController {
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
}
