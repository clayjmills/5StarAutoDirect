//
//  Message.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import UIKit

class Message: NSObject {
    
    private let textKey = "text"
    private let toIDKey = "toID"
    
    var text: String?
    var toID: String?
    
    init(text: String?, toID: String){
        self.text = text
        self.toID = toID
    }
    
    init?(jsonDictionary: [String: Any]) {
        guard let text = jsonDictionary[textKey] as? String,
            let toID = jsonDictionary[toIDKey] as? String else { return nil }
    }
}

//extension Message : Equatable {
//    static func ==(lhs: Message, rhs: Message) -> Bool {
//        return lhs.text == rhs.text && lhs.toID == rhs.toID
//    }
//}
