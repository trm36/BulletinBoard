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
    
    //delete

}

