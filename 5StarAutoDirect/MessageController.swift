//
//  MessageController.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import Foundation
import UIKit

struct MessageController {
    
    static let shared = MessageController()
    
    var messages: [Message] = []
    
    mutating func createMessage(text: String) {
        let message = Message(text: text)
        messages.insert(message, at: 0)
    }
    
}
