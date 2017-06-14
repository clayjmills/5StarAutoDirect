//
//  MessageController.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import Foundation

struct MessageController {
    
    static let shared = MessageController()
    
    func createMessage(text: String) {
        let message = Message(text: text)
    }
    
    func deleteMessage() {
        
    }
}
