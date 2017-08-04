import UIKit
import Firebase

// I may need two different properties, one for the user(broker), and one for the person the user is interacting with, i.e. customer property

class MessageConvoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var messagesTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    static let shared = MessageConvoViewController()
    
    var messages = [Message]()
    
    var user: User? {
        didSet {
            observeMessages()
            //            if (user?.isBroker)! {
            //                sendButton.setTitle("Message \(String(describing: user?.name))", for: .normal)
            //            } else {
            //                sendButton.setTitle("Message Broker", for: .normal)
            //            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = user?.name
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        handleSend()
        observeMessages()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    // Mark: - TableView Data Source Functions
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "receivedMessageCell", for: indexPath) as? MessageTableViewCell else { return UITableViewCell() }
        let message = messages[indexPath.row]
        cell.textLabel?.text = message.text
        return cell
    }
    
    
    func observeMessages() {
        let ref = Database.database().reference().child("messages")
        ref.observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                guard let message = Message(jsonDictionary: dictionary) else { return }
                message.setValuesForKeys(dictionary)
                self.messages.append(message)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }, withCancel: nil)
    }
    
    func handleSend() {
        if messagesTextField.text != "" {
            let ref = Database.database().reference().child("messages")
            
            let childRef = ref.childByAutoId()
            guard let input = messagesTextField.text else {return}
            let name = user?.name
            let values = ["text":input, "name": name]
            ref.updateChildValues(values as Any as! [AnyHashable : Any])
            messagesTextField.text = ""
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        messagesTextField.resignFirstResponder()
    }

    
//    func textFieldShouldReturn(_ messageTextView: UITextView) -> Bool {
//        handleSend()
//        return true
//    }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        scrollView.setContentOffset(CGPoint(x:0, y:190), animated: true)
//    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
//    }
//        
    // keyboard under text fields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        scrollView.setContentOffset(CGPoint(x:0, y:190), animated: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
    }

    

}
