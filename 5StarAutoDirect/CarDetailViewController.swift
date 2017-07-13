//
//  CarDetailViewController.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import UIKit
import Firebase

class CarDetailViewController: UIViewController {

    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var budgetTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var otherTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let make = makeTextField.text, let model = modelTextField.text, let budget =  budgetTextField.text, let color = colorTextField.text, let other = otherTextField.text else { return }
        CarController.shared.createCar(make: make, model: model, budget: budget, color: color, other: other)
    }
    
    func presentTextFieldsAreEmptyAlert() {
        let emptyTextFieldsAlertController = UIAlertController(title: "One or more text fields are still empty", message: "Submit anyways?", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Add", style: .cancel, handler: nil)
        let submitAction = UIAlertAction(title: "Submit", style: .default) { (createCar) in
            CarController.shared.createCar(make: make, model: model, budget: budget, color: color, other: other)
        }
    }
}






