//
//  MessageDetailViewController.swift
//  5StarAutoDirect
//
//  Created by Alex Whitlock on 6/27/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import UIKit

class MessageDetailViewController: UICollectionViewController {
    
    var user: User? {
        didSet {
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = user else { return }
        
        navigationItem.title = "\(user.name)"
        collectionView?.backgroundColor = UIColor.AutoBlue
        setupInputComponents()
    }

    
    func setupInputComponents() {
            let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        
        // constraining with anchors
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let sendButton = UIButton(type: .system )
        sendButton.setTitle("Send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(sendButton)
        // constraining with anchors
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
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
