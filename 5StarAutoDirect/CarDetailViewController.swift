//
//  CarDetailViewController.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import UIKit
import AVFoundation

class CarDetailViewController: UIViewController {
    
    static let shared = CarDetailViewController()
    static let userController = UserController()
    
    enum TextType: Int {
        
        case make
        case model
        case budget
        case color
        case other
        
        var alertTitle: String? {
            switch self {
            case .make:
                return "Please enter a make"
            case .model:
                return "Please enter a model"
            case .budget:
                return"Please enter a budget"
            case .color:
                return "Please enter a color"
            default:
                return nil
            }
        }
    }
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var budgetTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var otherTextField: UITextField!
    
    // MARK: - Properties
    
    fileprivate let carSoundPlayer = SoundPlayer(sound: .ferrari)

    var user: User?
    fileprivate var isHighlighted = true
    fileprivate var originalBorderColor: CGColor?
    fileprivate var textFields: [UITextField] {
        return [makeTextField, modelTextField, budgetTextField, colorTextField, otherTextField]
    }
    fileprivate var requiredTextFields: [UITextField] {
         return [makeTextField, modelTextField, budgetTextField, colorTextField]
    }
    
    
    // MARK: - Life - Cycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carSoundPlayer.prepare()
        originalBorderColor = textFields.first?.layer.borderColor
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reactToKeyboardShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reactToKeyboardHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    // MARK: - IBActions
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        print("button tapped")
        print(UserController.shared.currentUser?.identifier)
        let textFieldsToShake = requiredTextFields.filter { $0.text == nil || $0.text!.isEmpty }
        
        if textFieldsToShake.isEmpty, let newCar = constructedCar() {
            //TODO: - verify func is working correctly
            UserController.shared.saveCarToUser(car: newCar, completion: nil)
            playCarSound()
            performSegue(withIdentifier: "toWelcomeVC", sender: self)
        } else {
            textFieldsToShake.forEach { textField in
                emptyTextfieldDetected(textField)
            }
        }
    }
    
    @IBAction func viewTapped(_ sender: Any) {
        view.endEditing(false)
    }
    
    func reactToKeyboardShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo, let keyboardFrame: CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else
        { return }
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    func reactToKeyboardHide(_ notification: Notification) {
        scrollView.contentInset = .zero
    }
    
}


// MARK: - Internal

extension CarDetailViewController {

    fileprivate func emptyTextfieldDetected(_ textField: UITextField) {
        toggleTextField(textfield: textField, isRed: true)
        shake(textField)
    }
    
    fileprivate func toggleTextField(textfield: UITextField, isRed: Bool) {
        let color = isRed ? UIColor.red.cgColor : originalBorderColor
        textfield.layer.borderColor = color
        textfield.layer.borderWidth = isRed ? 1.0 : 0
    }
    
    fileprivate func shake(_ textField: UITextField) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        textField.layer.add(animation, forKey: "shake")
    }
    
    fileprivate func playCarSound() {
        carSoundPlayer.play()
    }
    
    func constructedCar() -> Car? {
        guard let make = makeTextField.text, let model = modelTextField.text, let budget = budgetTextField.text, let color = colorTextField.text, let otherAttributes = otherTextField.text else { return nil }
        return Car(make: make, model: model, budget: budget, color: color, otherAttributes: otherAttributes)
    }
    
}


// MARK: - TextField Delegate

extension CarDetailViewController: UITextFieldDelegate {
    
    // TODO: add initializer for Car obj with textfield input
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let index = textFields.index(of: textField), index < textFields.count - 1, case let nextTextField = textFields[index + 1] {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        toggleTextField(textfield: textField, isRed: false)
    }
    
}
