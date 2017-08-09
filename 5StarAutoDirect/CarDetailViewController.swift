//
//  CarDetailViewController.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class CarDetailViewController: UIViewController, UITextFieldDelegate {
    
    var audioPlayer = AVAudioPlayer()
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var budgetTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var otherTextField: UITextField!
    
    static let shared = CarDetailViewController()
    
    var carCreated: Bool = true
    var isHighlighted = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ferrari sound plays when button tapped
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Ferrari", ofType: "m4a")!))
            audioPlayer.prepareToPlay()
        }
        catch {
            print(error)
        }
        
    }
    
    var user: User?
    
    @IBAction func submitButtonTapped(_ sender: Any) {
    
        
        guard let make = makeTextField.text, let model = modelTextField.text, let budget =  budgetTextField.text, let color = colorTextField.text, let other = otherTextField.text else { return }
        
        if carCreated {
            
            if make == "" {
                self.emptyMake()
            }
            if model == "" {
                self.emptyModel()
            }
            if budget == "" {
                self.emptyBudget()
            }
            if color == "" {
                self.emptyColor()
            }
            if other == "" {
                self.emptyOther()
            } else {
                
                //plays the sound
                audioPlayer.play()
                
                self.performSegue(withIdentifier: "toWelcomeVC", sender: self)
            }
        }
    }
    
    // MARK: - Textfield border color change functions
    
    func changeToRed() {
        let redCGColor = UIColor.red.cgColor
        
        switch UITextField() {
        case makeTextField:
            makeTextField.layer.borderColor = redCGColor
            makeTextField.layer.borderWidth = 1.0
            shake(textfieldLayer: makeTextField.layer)
        case modelTextField:
            modelTextField.layer.borderColor = redCGColor
            modelTextField.layer.borderWidth = 1.0
            shake(textfieldLayer: modelTextField.layer)
        case budgetTextField:
            budgetTextField.layer.borderColor = redCGColor
            budgetTextField.layer.borderWidth = 1.0
            shake(textfieldLayer: budgetTextField.layer)
        case colorTextField:
            colorTextField.layer.borderColor = redCGColor
            colorTextField.layer.borderWidth = 1.0
            shake(textfieldLayer: colorTextField.layer)
        default:
            print("Break Statement")
            break
        }
    }
    
    // MARK: - Animation Functions
    
    fileprivate func shake(textfieldLayer: CALayer) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        textfieldLayer.add(animation, forKey: "shake")
    }
    
    // MARK: - Alert Controller Functions
    let emptyTextFieldController = UIAlertController(title: "", message: nil, preferredStyle: .alert)
    let dismissAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
    
    func presentAlertControllerWithDismiss(alertController: UIAlertController, action: UIAlertAction) {
    present(alertController, animated: true, completion: nil)
    alertController.addAction(dismissAction)
    }
    
    
    func emptyMake() {
        
        let emptyMakeAlertController = UIAlertController(title: AlertText.make.title, message: nil, preferredStyle: .alert)
       presentAlertControllerWithDismiss(alertController: emptyMakeAlertController, action: dismissAction)
    }
    
    func emptyModel() {
        let emptyModelAlertController = UIAlertController(title: AlertText.model.title, message: nil, preferredStyle: .alert)
       presentAlertControllerWithDismiss(alertController: emptyModelAlertController, action: dismissAction)
    }
    
    func emptyBudget() {
        let emptyBudgetAlertController = UIAlertController(title: AlertText.budget.title, message: nil, preferredStyle: .alert)
        presentAlertControllerWithDismiss(alertController: emptyBudgetAlertController, action: dismissAction)
    }
    
    func emptyColor() {
        let emptyColorAlertController = UIAlertController(title: AlertText.color.title, message: nil, preferredStyle: .alert)
        presentAlertControllerWithDismiss(alertController: emptyColorAlertController, action: dismissAction)
    }
    //FIXME: - finish this alert
    func emptyOther() {
        let emptyOtherAlertController = UIAlertController(title: AlertText.other.message, message: nil, preferredStyle: .alert)
        emptyOtherAlertController.addAction(dismissAction)
        present(emptyOtherAlertController, animated: true, completion: nil)
    }
    
    // keep textfields on top of keyboard
    
    // TODO: customize each text field to stay in view when keyboard is up
    // TODO: customize each keyboard (take away predictive text options)
    // TODO: add inirializer for Car obj with textfield input
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y:190), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y:0), animated: true)
    }
    
}

enum AlertText: String {
    
    case make
    case model
    case budget
    case color
    case other
    
    var title: String? {
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
    
    var message: String? {
        switch self {
        case .other:
            return "Would you like to add any other notes before moving on?"
        default:
            return nil
        }
    }
    
}
