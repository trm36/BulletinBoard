//
//  MessageController.swift
//  BB
//
//  Created by Taylor Mott on 03-Aug-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import Foundation
import CloudKit

class MessageController {
    
    static let shared = MessageController()
    
    private(set) var messages: [Message] = []
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
    
    
}
