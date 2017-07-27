//
//  UserInfoTableViewCell.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 7/20/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var carSpecsLabel: UILabel!
    
    var user: User? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let user = user else { return }
        nameLabel.text = user.name
        emailLabel.text = user.email
        phoneLabel.text = user.phone
        carSpecsLabel.text = "Make: \(user.car.make), Model: \(user.car.model), Budget: \(user.car.budget), Color: blah blah blah \(user.car.color), Other: \(user.car.otherAttributes) blah blah blah"
    }
    

}
