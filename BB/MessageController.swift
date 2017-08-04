//
//  MessageController.swift
//  BB
//
//  Created by Taylor Mott on 03-Aug-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import Foundation
import CloudKit

extension MessageController {
    static let didRefreshNotification = Notification.Name("didRefreshNotification")
}

class MessageController {
    
    static let shared = MessageController()
    
    private(set) var messages: [Message] = [] {
        didSet {
            DispatchQueue.main.async(execute: {
                NotificationCenter.default.post(name: MessageController.didRefreshNotification, object: self)
            })
        }
    }
    
    private let cloudKitManager = CloudKitManager()
    
    func post(_ message: Message, completion: @escaping ((Error?) -> Void) = {_ in }) {
        
        let record = message.cloudKitRecord
        
        cloudKitManager.save(record) { (error: Error?) in
            
            defer { completion(error) }
            
            if let error = error {
                NSLog("Error saving \(message) to CloudKit: \(error)")
            } else {
                self.messages.append(message)
            }
        }
    }
    
    private func refresh(completion: @escaping ((Error?) -> Void) = {_ in }) {
        let sortDescriptors = [NSSortDescriptor(key: Message.dateKey, ascending: false)]
        
        cloudKitManager.fetchRecords(ofType: Message.recordType, sortDescriptors: sortDescriptors) { (records: [CKRecord]?, error: Error?) in
            
            defer { completion(error) }
            
            if let error = error {
                NSLog("Error fetching messages: \(error)")
            } else {
                guard let records = records else { return }
                
                self.messages = records.flatMap({ Message(cloudKitRecord: $0) })
            }
        }
    }
    
    init() {
        refresh()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
