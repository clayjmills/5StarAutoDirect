//
//  MessagesTableViewController.swift
//  5StarAutoDirect
//
//  Created by Alex Whitlock on 6/27/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import UIKit

class MessagesTableViewController: UITableViewController {
    
    static let shared = MessagesTableViewController()
    
    var user: User? {
        didSet {
            navigationItem.title = user?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeMessages()
    }
    
    func observeMessages() {
//        let ref = 
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "receivedMessageCell", for: indexPath)
        cell.textLabel?.text = "You have a test cell"
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func testButtonTapped(_ sender: Any) {
            showChatController()
    }
    
    func showChatController() {
        let messageDetailVC = MessageDetailViewController()
         navigationController?.pushViewController(messageDetailVC, animated: true)
    }
    
    func handleNewMessage() {
        
    }
    
    // MARK: - Navigation
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "<#segueIdentifier#>" {
//            guard let indexPath = tableView.indexPathForSelectedRow, let detailVC = segue.destination as? <#DetailVCName#> else { return }
//            let <#object#> = <#ModelController#>.shared.<#object#>[indexPath.row]
//            detailVC.<#object#> <#from dvc File#>= <#object#>
//        }
//    } 
}
