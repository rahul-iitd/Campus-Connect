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
    
    func receiveMessage(from: String, to: String, onSuccess: @escaping(Message)->Void){
        let ref = Ref().databaseMessageSentTo(from: from, to: to)
        ref.observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String,Any>{
                if let message = Message.transformMessage(dict: dict, keyId: snapshot.key){
                    onSuccess(message)
                }
                
            }
        }
    }
    
}
