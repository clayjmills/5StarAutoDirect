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
    
    var user: User? {
        didSet {
            updateViews()
        }
    }

    
    func updateViews() {
        guard let user = user else { return }
        if user.currentStep == .One {
            oneButton.imageView?.image = #imageLiteral(resourceName: "blueRect")
        }
        if user.currentStep == .Two {
            twoButton.imageView?.image = #imageLiteral(resourceName: "blueRect")
        }
        if user.currentStep == .Three {
            threeButton.imageView?.image = #imageLiteral(resourceName: "blueRect")
        }
        if user.currentStep == .Four {
            fourButton.imageView?.image = #imageLiteral(resourceName: "blueRect")
        }
        if user.currentStep == .Five {
            fiveButton.imageView?.image = #imageLiteral(resourceName: "blueRect")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func sendMessageButtonTapped(_ sender: Any) {
        messageTextView.text = ""
        // TODO: - Actually, yaknow, send the message
    }
    
    @IBAction func oneButtonTapped(_ sender: Any) {
        user?.currentStep = .One
    }
    
    @IBAction func twoButtonTapped(_ sender: Any) {
        user?.currentStep = .Two
    }
    
    @IBAction func threeButtonTapped(_ sender: Any) {
        user?.currentStep = .Three
    }
    
    @IBAction func fourButtonTapped(_ sender: Any) {
        user?.currentStep = .Four
    }
    
    @IBAction func fiveButtonTapped(_ sender: Any) {
        user?.currentStep = .Five
    }
    
}
