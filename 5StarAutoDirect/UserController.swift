//
//  UserController.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import Foundation
import Firebase

class UserController /* FIXME: - add delegate back here*/ {
    
    static var shared = UserController()
    
    let ref = Database.database().reference(fromURL: "https://starautodirect-5b1fc.firebaseio.com/")
    
    var users = [User]() {
        didSet {
//            delegate?.usersWereUpdatedTo(users: users)
//            usersWereUpdatedTo(users: users)
        }
    }
    
    func usersWereUpdatedTo(users: [User]) {
        self.users = users
    }
    
    weak var delegate: UserControllerDelegate?
    
    init() {
        self.fetchUsers()
    }
    
    func saveUserToFirebase(name: String, phone: String, email: String, password: String, completion: @escaping(_ isBroker: Bool?) -> Void) {
        
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
            
            let referenceForCurrentUser = self.ref.child(brokerOrUserRefString).child(uidString)
            //            referenceForCurrentUser.setValue(user.jsonRepresentation)
            referenceForCurrentUser.setValue(user.jsonRepresentation, withCompletionBlock: { (error, ref) in
                UserController.completeSignIn(id: user.name)
                completion(broker)
            })
            
            
            
            //// DO NOT DELETE might need this for the login screen, only Clay can delete this
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
    
    // getting users from firebase
    func fetchUsers() {
                ref.child("users").observe(.value, with: { (snapshot) in
            
            if let dictionaryOfUsers = snapshot.value as? [String:[String:Any]] {
                let users = dictionaryOfUsers.flatMap( { User(jsonDictionary: $0.value, identifier: $0.key) } )
                self.users = users
            }
        })
    }
    
    static func completeSignIn(id: String) {
        let keyChain = DatabaseManager().keyChain
        keyChain.set(id , forKey: "uid")
    }
}

protocol UserControllerDelegate: class {
    func usersWereUpdatedTo(users: [User])
}
