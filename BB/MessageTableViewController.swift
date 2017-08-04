//
//  ViewController.swift
//  BB
//
//  Created by Taylor Mott on 03-Aug-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import UIKit

class MessageTableViewController: UITableViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func postButtonTapped() {
        guard let messageText = textField.text else { return }
        textField.resignFirstResponder()
        let message = Message(messageText: messageText, date: Date())
        MessageController.shared.post(message)
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(messagesWereUpdated(_:)),
                                               name: MessageController.didRefreshNotification,
                                               object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageController.shared.messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        
        let messages = MessageController.shared.messages
        let message = messages[indexPath.row]
        
        cell.textLabel?.text = message.messageText
        cell.detailTextLabel?.text = dateFormatter.string(from: message.date)
        
        return cell
    }
    
    @objc func messagesWereUpdated(_ notification: Notification) {
        tableView.reloadData()
    }

    
    
    
    
    
    
    
    
    
    
    

}

