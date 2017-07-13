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

        // TODO: - check if text fields are empty
        // if {
        textFieldsEmptyAlertController()
        // } else {
        CarController.shared.createCar(make: make, model: model, budget: budget, color: color, other: other)
    //}
    
    }
    
    func textFieldsEmptyAlertController() {
        guard let make = makeTextField.text, let model = modelTextField.text, let budget =  budgetTextField.text, let color = colorTextField.text, let other = otherTextField.text else { return }
        
        
        let emptyTextFieldsAlertController = UIAlertController(title: "Fill out all fields", message: "Thank you", preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        // To Do: delete if never used again
        //let submitAction = UIAlertAction(title: "Submit", style: .default) { (createCar) in
           // CarController.shared.createCar(make: make, model: model, budget: budget, color: color, other: other)
        //}
        
        emptyTextFieldsAlertController.addAction(dismissAction)
        //emptyTextFieldsAlertController.addAction(submitAction)
        present(emptyTextFieldsAlertController, animated: true, completion: nil)
    }
}
