//
//  BrokerMessageDetailViewController.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 7/17/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import UIKit
import Firebase

class BrokerMessageDetailViewController: UIViewController {
    
    @IBOutlet weak var sendToLabel: UILabel!
    
    @IBOutlet weak var messageTextView: UITextView!
    
    var user: User? {
        didSet {
            updateViews()
        }
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = user else {return}
        navigationItem.title = "Create email"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleSend() {
        if messageTextView.text != "" {
            let ref = Database.database().reference().child("messages")
            
            let childRef = ref.childByAutoId()
            guard let input = messageTextView.text else {return}
            let name = user?.name
            let values = ["text":messageTextView.text!, "name": name]
            ref.updateChildValues(values)
            messageTextView.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSend()
        return true
    }
    
    func updateViews() {
        guard let sendTo = sendToLabel,
            let user = user else {return}
        sendTo.text = "Send to \(user.name)"
    }
    // comment to test stuff


}
