//
//  MessageDetailViewController.swift
//  5StarAutoDirect
//
//  Created by Alex Whitlock on 6/27/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import UIKit
import Firebase

class MessageDetailViewController: UIViewController, UITextFieldDelegate {
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Message..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    var user: User? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = user else { return }
        
        navigationItem.title = "\(user.name)"
//        tableView.backgroundColor = UIColor.AutoBlue
        setupInputComponents()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        cell.textLabel?.text = "test message cell"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func setupInputComponents() {
        
        // Container
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        // constraining with anchors
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Send Button
        let sendButton = UIButton(type: .system )
        sendButton.setTitle("Send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(sendButton)
        // constraining with anchors
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        //target
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        
        
        //Input TextField
        containerView.addSubview(inputTextField)
        //constraining w anchors
        inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        let separator = UIView()
        separator.backgroundColor = UIColor.AutoRed
        separator.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(separator)
        //constraining
        separator.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        separator.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        separator.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 0.8).isActive = true
    }
    
    func handleSend() {
        if inputTextField.text != "" {
            let ref = Database.database().reference().child("messages")
            
            let childRef = ref.childByAutoId()
            guard let input = inputTextField.text else { return }
            let name = user?.name
            let values = ["text":inputTextField.text!, "name": name]
            ref.updateChildValues(values)
            inputTextField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSend()
        return true
    }
    
    func updateViews() {
        // once we get the button stuff set up
        //        guard let user = user else { return }
        //        if user.currentStep == .One {
        //            oneButton.imageView?.image = #imageLiteral(resourceName: "blueRect")
        //        }
        //        if user.currentStep == .Two {
        //            twoButton.imageView?.image = #imageLiteral(resourceName: "blueRect")
        //        }
        //        if user.currentStep == .Three {
        //            threeButton.imageView?.image = #imageLiteral(resourceName: "blueRect")
        //        }
        //        if user.currentStep == .Four {
        //            fourButton.imageView?.image = #imageLiteral(resourceName: "blueRect")
        //        }
        //        if user.currentStep == .Five {
        //            fiveButton.imageView?.image = #imageLiteral(resourceName: "blueRect")
        //        }
    }
    
    
}
