
import Firebase
import FirebaseDatabase
import UIKit

class MessageController {
    
    static var shared = MessageController()
    
    var messages = [Message]() {
        didSet {
            
        }
    }
    
    let ref = Database.database().reference(fromURL: "https://starautodirect-5b1fc.firebaseio.com/")
    
    func fetchMessages(completion: @escaping ([Message]?) -> Void) {
        ref.child("messages").observe(.value, with: { (snapshot) in
            
            if let dictionaryOfMessages = snapshot.value as? [String:[String:Any]] {
 //               print(dictionaryOfMessages)
                let messages = dictionaryOfMessages.flatMap({Message(jsonDictionary: $0.value) } )
//                print(messages)
                completion(messages)
            }
        })
        
    }
}
