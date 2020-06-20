//
//  InboxApi.swift
//  Campus Connect
//
//  Created by Rahul Bansal on 20/06/20.
//  Copyright © 2020 Rahul Bansal. All rights reserved.
//


import Foundation
import Firebase

class InboxApi{
    func lastMessages(uid: String){
        let ref = Ref().databaseInboxForUser(uid: uid)
        ref.observe(DataEventType.childAdded) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String,Any>{
                print(dict)
            }
        }
        
    }
    
}
