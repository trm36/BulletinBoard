//
//  CloudKitManager.swift
//  BB
//
//  Created by Taylor Mott on 03-Aug-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import Foundation
import CloudKit

private let CreatorUserRecordIDKey = "creatorUserRecordID"
private let LastModifiedUserRecordIDKey = "creatorUserRecordID"
private let CreationDateKey = "creationDate"
private let ModificationDateKey = "modificationDate"

class CloudKitManager {
    
    let database = CKContainer.default().publicCloudDatabase
    
    func fetchRecords(ofType type: String,
                      sortDescriptors: [NSSortDescriptor]? = nil,
                      predicate: NSPredicate = NSPredicate(value: true),
                      completion: @escaping ([CKRecord]?, Error?) -> Void) {
        let query = CKQuery(recordType: type, predicate: predicate)
        query.sortDescriptors = sortDescriptors
        
        database.perform(query, inZoneWith: nil, completionHandler: completion)
    }
    
    func save(_ record: CKRecord, completion: @escaping ((Error?) -> Void) = {_ in }) {
        database.save(record) { (_: CKRecord?, error: Error?) in
            completion(error)
        }
    }
    
    func subscribeToCreationOfRecords(ofType type: String, predicate: NSPredicate = NSPredicate(value: true), completion: @escaping ((Error?) -> Void) = {_ in }) {
        
        let subscription = CKQuerySubscription(recordType: type, predicate: predicate, options: .firesOnRecordCreation)
        
        let notificationInfo = CKNotificationInfo()
        notificationInfo.alertBody = "There's a new message on the bulletin board."
        subscription.notificationInfo = notificationInfo
        
        database.save(subscription) { (_: CKSubscription?, error: Error?) in
            
            defer { completion(error) }
            
            if let error = error {
                NSLog("Error saving subscription: \(error)")
            }
        }
    }

    
    
    
    
    
    
    
}

