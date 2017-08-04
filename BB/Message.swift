//
//  Message.swift
//  BulletinBoard
//
//  Created by Andrew Madsen on 6/17/16.
//  Copyright © 2016 Open Reel Software. All rights reserved.
//

import Foundation

struct Message {
	let messageText: String
	let date: Date
}

//CLOUD KIT



extension Message {
    static var messageTextKey: String { return "MessageText" }
    static var dateKey: String { return "Date" }
    
    
}
