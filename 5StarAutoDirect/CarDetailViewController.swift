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
    func emptyMake() {
        let emptyMakeAlertController = UIAlertController(title: "Please enter a make", message: nil, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        emptyMakeAlertController.addAction(dismissAction)
        present(emptyMakeAlertController, animated: true, completion: nil)
    }
    
    func emptyModel() {
        let emptyModelAlertController = UIAlertController(title: "Please enter a model", message: nil, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        emptyModelAlertController.addAction(dismissAction)
        present(emptyModelAlertController, animated: true, completion: nil)
    }
    
    func emptyBudget() {
        let emptyBudgetAlertController = UIAlertController(title: "Please enter a budget", message: nil, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        emptyBudgetAlertController.addAction(dismissAction)
        present(emptyBudgetAlertController, animated: true, completion: nil)
    }
    
    func emptyColor() {
        let emptyColorAlertController = UIAlertController(title: "Please enter a color", message: nil, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        emptyColorAlertController.addAction(dismissAction)
        present(emptyColorAlertController, animated: true, completion: nil)
    }
    
    func emptyOther() {
        let emptyOtherAlertController = UIAlertController(title: "Please type NA if other is not applicable", message: nil, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        emptyOtherAlertController.addAction(dismissAction)
        present(emptyOtherAlertController, animated: true, completion: nil)
    }
    
    // keep textfields on top of keyboard
    
    // TODO: customize each text field to stay in view when keyboard is up
    // TODO: customize each keyboard (take away predictive text options)
    
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
