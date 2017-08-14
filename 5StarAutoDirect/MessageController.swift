//
//  MessageController.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class MessageController {
    
    static var shared = MessageController()
    
    let ref = Database.database().reference(fromURL: "https://starautodirect-5b1fc.firebaseio.com/")
    
    var messages = [Message]() {
        didSet {
        }
    }
    weak var delegate: MessageController?
    
    func fetchMessages(completion: @escaping ([Message]?) -> Void) {
        ref.child("messages").observe(.value, with: {(snapshot) in
            
            // i'm going one level too far here i think
            if let dictionaryOfMessages = snapshot.value as? [String:[String: Any]] {
                let messages = dictionaryOfMessages.flatMap({ Message(jsonDictionary: $0.value, identifier: $0.key) } )
                completion(messages)
            }
        })
    }
  
    
//    static func fetchMessages(completion: @escaping ([Message]) -> Void) {
//        guard let unwrappedURL = NetworkController.baseURL else { return }
//        let url = unwrappedURL.appendingPathExtension("json")
//        
//        NetworkController.performRequest(for: url, httpMethod: .Get, urlParameters: nil, body: nil) { (data, error) in
//            if let error = error {
//                print("Error: \(error.localizedDescription) File: \(#file) Line: \(#line)")
//                completion([]); return
//            }
//            
//            guard let data = data,
//                let jsondictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: [String: String]] else { completion([]); return }
//            
//            let messages = jsondictionary.flatMap({ Message(jsonDictionary: $0.value)})
//            completion(messages)
//        }
//    }

    // Alex commented out for messages
//    func createMessage(text: String, toID: String) {
//        guard let unwrappedURL = NetworkController.baseURL else { return }
//        let url = unwrappedURL.appendingPathComponent("json")
//        
//        let message = Message(jsonDictionary: text, identifier: toID)
//        
//        NetworkController.performRequest(for: url, httpMethod: .Post, urlParameters: nil, body: nil) { (data, error) in
//            guard let data = data, let responseDataString = String(data: data, encoding: .utf8) else { return }
//            
//            if let error = error {
//                print("Error: \(error.localizedDescription) File: \(#file) Line: \(#line)")
//            } else if responseDataString.contains("error") {
//                print("Error: \(responseDataString)")
//                
//            } else {
//                print("Successfully saved data to endpoint")
//                
//            }
//        }
//        messages.append(messages)
//    }
}
