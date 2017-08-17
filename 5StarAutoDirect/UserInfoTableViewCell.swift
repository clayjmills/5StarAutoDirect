//
//  UserInfoTableViewCell.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 7/20/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import UIKit
import Firebase

class UserInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var carSpecsLabel: UILabel!
    
//    var currentUser = UserController.shared.currentUser
    var user: User? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let currentUser = user else { return }
        nameLabel.text = currentUser.name
        emailLabel.text = currentUser.email
        phoneLabel.text = currentUser.phone
        carSpecsLabel.text = "Make: \(currentUser.car.make), Model: \(currentUser.car.model), Budget: \(currentUser.car.budget), Color: \(currentUser.car.color), Other: \(String(describing: currentUser.car.otherAttributes))"
//        nameLabel.text = user.name
//        emailLabel.text = user.email
//        phoneLabel.text = user.phone
//        carSpecsLabel.text = "Make: \(user.car.make), Model: \(user.car.model), Budget: \(user.car.budget), Color: \(user.car.color), Other: \(user.car.otherAttributes)"
    }
}
