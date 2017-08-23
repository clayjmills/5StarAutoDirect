//
//  MessageTableViewCell.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 8/3/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageTextLabel: UILabel!
    
    var message: Message? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let message = message else { return }
        messageTextLabel.text = message.text
        
        // use when we have users able to write back to the broker
        //            if message.toID == logged in user.name {
        //            messageTextLabel.textAlignment == .left
        //            } else {
        //            messageTextLabel.textAlignment == .right
        //            }
        
                    messageTextLabel.numberOfLines = 0
    }
    
}
