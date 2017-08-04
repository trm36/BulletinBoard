//
//  Message.swift
//  BulletinBoard
//
//  Created by Andrew Madsen on 6/17/16.
//  Copyright © 2016 Open Reel Software. All rights reserved.
//

import Foundation
import CloudKit

struct Message {
	let messageText: String
	let date: Date
}

//CLOUD KIT



extension Message {
    static var messageTextKey: String { return "MessageText" }
    static var dateKey: String { return "Date" }
    
    static var recordType: String { return "Message" }
    
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Message.recordType)
        record[Message.messageTextKey] = messageText as CKRecordValue
        record[Message.dateKey] = date as NSDate
        return record
    }
    
    init?(cloudKitRecord: CKRecord) {
        guard let messageText = cloudKitRecord[Message.messageTextKey] as? String,
        let date = cloudKitRecord[Message.dateKey] as? Date,
            cloudKitRecord.recordType == Message.recordType else { return nil }
        
        self.init(messageText: messageText, date: date)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
