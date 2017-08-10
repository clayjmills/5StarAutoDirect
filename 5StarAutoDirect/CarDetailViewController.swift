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

class CarDetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var budgetTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var otherTextField: UITextField!
    
    static let shared = CarDetailViewController()
    
    fileprivate let emptyTextFieldController = UIAlertController(title: "", message: nil, preferredStyle: .alert)
    fileprivate let dismissAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
    //FIXME: - why is this user being called by another VC and not a Controller? --> userHomeVC line 40
    var user: User?
    fileprivate var audioPlayer = AVAudioPlayer()
    fileprivate var carCreated: Bool = true
    fileprivate var isHighlighted = true
    
    // Life - Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        playCarSound()
    }
    
    //FIXME: - clean up function
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
   fileprivate func emptyTextfieldDetected() {
        
        switch UITextField() {
        case makeTextField:
            changeTextfieldBorderWidthAndColor(textfield: makeTextField)
            shake(textfieldLayer: makeTextField.layer)
        case modelTextField:
            changeTextfieldBorderWidthAndColor(textfield: modelTextField)
            shake(textfieldLayer: modelTextField.layer)
        case budgetTextField:
            changeTextfieldBorderWidthAndColor(textfield: modelTextField)
            shake(textfieldLayer: budgetTextField.layer)
        case colorTextField:
            changeTextfieldBorderWidthAndColor(textfield: colorTextField)
            shake(textfieldLayer: colorTextField.layer)
        default:
            print("Break Statement")
            break
        }
    }
    
   fileprivate func changeTextfieldBorderWidthAndColor(textfield: UITextField) {
        let redCGColor = UIColor.red.cgColor
        
        textfield.layer.borderColor = redCGColor
        textfield.layer.borderWidth = 1.0
    }
    
    // MARK: - Animation & Sound Functions
    fileprivate func shake(textfieldLayer: CALayer) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        textfieldLayer.add(animation, forKey: "shake")
    }
    
    fileprivate func playCarSound() {
        do {
            // ferrari sound plays when button tapped
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Ferrari", ofType: "m4a")!))
            audioPlayer.prepareToPlay()
        }
        catch {
            print(error)
        }
    }
    
    // MARK: - Alert Controller Functions
    fileprivate func presentAlertControllerWithAction(alertController: UIAlertController, action: UIAlertAction) {
    present(alertController, animated: true, completion: nil)
    alertController.addAction(dismissAction)
    }
    
    fileprivate func emptyMake() {
        let emptyMakeAlertController = UIAlertController(title: AlertText.make.title, message: nil, preferredStyle: .alert)
       presentAlertControllerWithAction(alertController: emptyMakeAlertController, action: dismissAction)
    }
    fileprivate func emptyModel() {
        let emptyModelAlertController = UIAlertController(title: AlertText.model.title, message: nil, preferredStyle: .alert)
       presentAlertControllerWithAction(alertController: emptyModelAlertController, action: dismissAction)
    }
    fileprivate func emptyBudget() {
        let emptyBudgetAlertController = UIAlertController(title: AlertText.budget.title, message: nil, preferredStyle: .alert)
        presentAlertControllerWithAction(alertController: emptyBudgetAlertController, action: dismissAction)
    }
    fileprivate func emptyColor() {
        let emptyColorAlertController = UIAlertController(title: AlertText.color.title, message: nil, preferredStyle: .alert)
        presentAlertControllerWithAction(alertController: emptyColorAlertController, action: dismissAction)
    }
    //FIXME: - finish this alert
    fileprivate func emptyOther() {
        let emptyOtherAlertController = UIAlertController(title: AlertText.other.message, message: nil, preferredStyle: .alert)
        emptyOtherAlertController.addAction(dismissAction)
        present(emptyOtherAlertController, animated: true, completion: nil)
    }
    
}


// MARK: - TextField Delegate

extension CarDetailViewController: UITextFieldDelegate {
    
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

