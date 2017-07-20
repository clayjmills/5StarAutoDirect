//
//  UserController.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import Foundation
import Firebase

struct UserController {
    
    static var shared = UserController()
    
    static let ref = Database.database().reference(fromURL: "https://starautodirect-5b1fc.firebaseio.com/")
    
    var users: [User] = [] {
        didSet {
            delegate?.usersWereUpdatedTo(users: users, on: self)
        }
    }
    
    weak var delegate: UserControllerDelegate?
    
    static func fetchUsers(completion: (([User]) -> Void)? = nil) {
        guard let unwrappedURL = NetworkController.baseURL else { return }
        let url = unwrappedURL.appendingPathExtension("json")
        
        NetworkController.performRequest(for: url, httpMethod: .Get, urlParameters: nil, body: nil) { (data, error) in
            if let error = error {
                print("Error: \(error.localizedDescription) File: \(#file) Line: \(#line)")
                completion?([]); return
            }
            
            guard let data = data else { completion?([]) ; return }
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] else { completion?([]); print("got to the data, didn't return it"); return }
            
            let users = jsonDictionary.flatMap({ User(jsonDictionary: $0.1 as! [String : Any], identifier: $0.0)})
            
            DispatchQueue.main.async {
                completion?(users)
            }
        }
    }
    
    static func saveUserToFirebase(name: String, phone: String, email: String, password: String, completion: @escaping(_ isBroker: Bool?) -> Void) {
        
        var brokerOrUserRefString = ""
        let broker: Bool
        
        if email.uppercased().contains("FIVESTARAUTODIRECT") {
            brokerOrUserRefString = "brokers"
            broker = true
        } else {
            brokerOrUserRefString = "users"
            broker = false
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            
            if let error = error {
                print(error)
                completion(nil)
                return
            }
            
            guard let uidString = user?.uid
                else { completion(nil); return }
            
            let defaultCar = Car(make: "", model: "", budget: "", color: "", otherAttributes: "")
            
            let user = User(name: name, phone: phone, email: email, isBroker: broker, messages: [], car: defaultCar, identifier: uidString)
            
            // Put authenticated user in firebase database under appropriate node.
            
            let referenceForCurrentUser = ref.child(brokerOrUserRefString).child(uidString)
//            referenceForCurrentUser.setValue(user.jsonRepresentation)
            referenceForCurrentUser.setValue(user.jsonRepresentation, withCompletionBlock: { (error, ref) in
                self.completeSignIn(id: user.name)
                completion(broker)
            })
            
            //            let usersReference = self.ref.child(brokerOrUserRefString).child(uid)
            //            let values = ["name": name, "email": email]
            //            ref.updateChildValues(values, withCompletionBlock: { (err, ref) in
            //
            //                if err != nil
            //                {
            //                    print(err)
            //                    return }
            //                print("Saved user successfully into Firebase db")
            //            })
            
            
            
            
            
            
            //            if !(email.contains(".")) {
            //                self.badEmail()
            //            } else if !(user.email?.contains("@"))! {
            //                self.badEmail()
            //            }
            //            if (user.phone?.characters.count)! < 10 {
            //                self.badPhoneNumberAC()
            //            }
            //            if password == "" {
            //                self.badPasswordAC()
            //            }
            //            if name == "" {
            //                self.badNameAC()
            //            }
            
            
            
            
        })
    }
    
    static func completeSignIn(id: String) {
        let keyChain = DatabaseManager().keyChain
        keyChain.set(id , forKey: "uid")
    }
}

protocol UserControllerDelegate: class {
    func usersWereUpdatedTo(users: [User], on controller: UserController)
}
