//
//  SignUpViewController.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//


///// fix login, right now it always goes to user home screen, even if logged in as broker the next time you login to your phone it goes to user home screen instead of user list


import UIKit
import FirebaseAuth
import KeychainSwift
import FirebaseDatabase
import AVFoundation

// We may want to put the code to tell what the initial VC is in the AppDelegate, appDidFinishLaunching instead of here

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    var audioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIImageView!
    @IBOutlet weak var signOutButton: UIButton!
    
    override func viewDidLoad() { // we can change this to VWA to stop the login from flashing
        super.viewDidLoad()
        
        //uploading sound to play on button
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Ferrari", ofType: "m4a")!))
            audioPlayer.prepareToPlay()
        }
        catch {
            print(error)
        }
        
        //making navigation controller transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        let keyChain = DatabaseManager().keyChain
        if keyChain.get("uid") != nil {
            performSegue(withIdentifier: "signinToUserHomeVC", sender: nil)
        }
        
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        guard let name = nameTextField.text, let phone = phoneTextField.text, let email = emailTextField.text, let password = passwordTextField.text, name != "", phone != "", email != "", password != "" else { presentMissingInfoAlert(); return }
        
        UserController.shared.saveUserToFirebase(name: name, phone: phone, email: email, password: password) { (isBroker) in
            
            // add sound to submit button
            self.audioPlayer.play()
            
            guard let isBroker = isBroker else { return }
            
            if isBroker {
                self.performSegue(withIdentifier: "signinToBrokerTVC", sender: self)
            } else {
                self.performSegue(withIdentifier: "signinToUserHomeVC", sender: self)
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signinToBrokerTVC" {
            let createdUser = BrokerTableViewController.shared.user
            if let detailVC = segue.destination as? BrokerTableViewController {
                detailVC.user = createdUser
            }
        } else {
            if segue.identifier == "signinToUserHomeVC"{
                let createdUser = UserHomeViewController.shared.user
                if let detailVC = segue.destination as? UserHomeViewController {
                    detailVC.user = createdUser
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
    }
    
    func presentMissingInfoAlert() {
        let pleaseEnterValidEmailAlertController = UIAlertController(title: "*All fields are required!", message: nil, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        pleaseEnterValidEmailAlertController.addAction(dismissAction)
        present(pleaseEnterValidEmailAlertController, animated: true, completion: nil)
    }
    
    
    //    func badEmail() {
    //        let pleaseEnterValidEmailAlertController = UIAlertController(title: "Please enter a valid email", message: nil, preferredStyle: .alert)
    //        let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    //        pleaseEnterValidEmailAlertController.addAction(dismissAction)
    //        present(pleaseEnterValidEmailAlertController, animated: true, completion: nil)
    //    }
    //
    //    func badPhoneNumberAC() {
    //        let badPhoneNumberAlertController = UIAlertController(title: "Please check that your phone number includes an area code and is a valid phone number", message: nil, preferredStyle: .alert)
    //        let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    //        badPhoneNumberAlertController.addAction(dismissAction)
    //        present(badPhoneNumberAlertController, animated: true, completion: nil)
    //    }
    //
    //    func badPasswordAC() {
    //        let badPasswordAlertController = UIAlertController(title: "Please enter a password", message: nil, preferredStyle: .alert)
    //        let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    //        badPasswordAlertController.addAction(dismissAction)
    //        present(badPasswordAlertController, animated: true, completion: nil)
    //    }
    //
    //    func badNameAC() {
    //        let badNameAlertController = UIAlertController(title: "Please enter first and last name", message: nil, preferredStyle: .alert)
    //        let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    //        badNameAlertController.addAction(dismissAction)
    //        present(badNameAlertController, animated: true, completion: nil)
    //    }
    
    
    
    
    // keyboard under text fields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        scrollView.setContentOffset(CGPoint(x:0, y:200), animated: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
    }
    
}
