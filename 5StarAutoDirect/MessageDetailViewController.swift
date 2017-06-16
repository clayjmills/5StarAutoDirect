//
//  MessageDetailViewController.swift
//  5StarAutoDirect
//
//  Created by Alex Whitlock on 6/16/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func sendMessageButtonTapped(_ sender: Any) {
        messageTextView.text = ""
    }
    
    @IBAction func oneButtonTapped(_ sender: Any) {
    }
    
    @IBAction func twoButtonTapped(_ sender: Any) {
    }
    
    @IBAction func threeButtonTapped(_ sender: Any) {
    }
    
    @IBAction func fourButtonTapped(_ sender: Any) {
    }
    
    @IBAction func fiveButtonTapped(_ sender: Any) {
    }
    
}
