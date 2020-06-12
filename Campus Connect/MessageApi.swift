//
//  MessageApi.swift
//  Campus Connect
//
//  Created by Rahul Bansal on 10/06/20.
//  Copyright © 2020 Rahul Bansal. All rights reserved.
//

import Foundation
import Firebase

class MessageApi{
    func sendMessage(from: String, to: String, value: Dictionary<String,Any>){
        let ref = Ref().databaseMessageSentTo(from: from, to: to)
		ref.childByAutoId().updateChildValues(value)
    }
    
}
