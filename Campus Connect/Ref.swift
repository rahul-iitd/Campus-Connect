//
//  Ref.swift
//  Campus Connect
//
//  Created by Rahul Bansal on 18/02/20.
//  Copyright © 2020 Rahul Bansal. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

let REFRENCE_USER = "users"
let STORAGE_LINK = "gs://campusconnect-85522.appspot.com"
let STORAGE_PROFILE = "profile"
let PRO_IMG_URL = "profileImageUrl"

class Ref {
    let databaseRoot : DatabaseReference = Database.database().reference()
    
    var databaseUsers : DatabaseReference {
        return databaseRoot.child(REFRENCE_USER)
    }
    
    func databaseSpecificProfile(uid:String) -> DatabaseReference{
        return databaseUsers.child(uid)
    }
    
    var databaseMessage: DatabaseReference {
        return databaseRoot.child("messages")
    }
    
    func databaseMessageSentTo(from : String, to: String)->DatabaseReference{
        return databaseMessage.child(from).child(to)
    }
    
    var databaseInbox : DatabaseReference {
        return databaseRoot.child("inbox")
    }
    
    func databaseInboxInfor(from : String, to: String)->DatabaseReference{
        return databaseInbox.child(from).child(to)
    }
    
    // Storage Ref
    
	let storageRoot = Storage.storage().reference(forURL: STORAGE_LINK)
    
    var storageProfile : StorageReference {
        return storageRoot.child(STORAGE_PROFILE)
    }
    var storageMessage: StorageReference {
        return storageRoot.child("messages")
    }
    
    func storageSpecificProfile(uid:String) -> StorageReference {
        return storageProfile.child(uid)
    }
    
    func storageSpecificImageMessage(id : String) -> StorageReference{
        return storageMessage.child("photo").child(id)
    }
    
    func storageSpecificVideoMessage(id : String) -> StorageReference{
        return storageMessage.child("video").child(id)
    }
    
}
