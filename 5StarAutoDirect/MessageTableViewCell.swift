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
        //            if message.toID == logged in user.name {
        //            messageTextLabel.textAlignment == .left
        //            } else {
        //            messageTextLabel.textAlignment == .right
        //            }
        
        // If not showing anything, delete this to get the first line of message text, then expand from there
                    messageTextLabel.numberOfLines = 0
    }
    
}
