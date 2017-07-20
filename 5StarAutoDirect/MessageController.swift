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

struct MessageController {
    
    static let shared = MessageController()
    
    var messages: [Message] = []
    
    static func fetchMessages(completion: @escaping ([Message]) -> Void) {
        guard let unwrappedURL = NetworkController.baseURL else { return }
        let url = unwrappedURL.appendingPathExtension("json")
        
        NetworkController.performRequest(for: url, httpMethod: .Get, urlParameters: nil, body: nil) { (data, error) in
            if let error = error {
                print("Error: \(error.localizedDescription) File: \(#file) Line: \(#line)")
                completion([]); return
            }
            
            guard let data = data,
                let jsondictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: [String: String]] else { completion([]); return }
            
            let messages = jsondictionary.flatMap({ Message(jsonDictionary: $0.value)})
            completion(messages)
        }
    }
}
