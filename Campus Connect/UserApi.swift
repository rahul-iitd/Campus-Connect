//
//  UserApi.swift
//  Campus Connect
//
//  Created by Rahul Bansal on 17/02/20.
//  Copyright © 2020 Rahul Bansal. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
import ProgressHUD
import FirebaseStorage
import FirebaseDatabase

class  UserApi {
    
    var currentUserId : String {return Auth.auth().currentUser != nil ? Auth.auth().currentUser!.uid : ""}
    
    func signIn(email: String, password: String, onSuccess: @escaping()->Void, onError: @escaping(_ errorMessage: String)->Void){
        Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
            if error != nil{
                onError(error!.localizedDescription)
                return
            }
            print(authData?.user.uid)
            onSuccess()
        }
    }
    
    func signUp(withUsername username: String, email: String, password: String, image: UIImage?,
                onSuccess: @escaping()->Void, onError: @escaping(_ errorMessage: String)->Void){
        
        guard let imageSelected = image else{
            ProgressHUD.showError("Please select your Profie Picture")
            return
        }
        ProgressHUD.show("Signing Up...")
        Auth.auth().createUser(withEmail: email, password: password)
        { (authDataResult,error) in
            if error != nil{
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            if let authData = authDataResult {
                print(authData.user.email)
                
                var dict: Dictionary<String,Any> = [
                    "uid": authData.user.uid,
                    "email": authData.user.email,
                    "username":username,
                    "profileImageUrl": "",
                    "status": "Hey there I am using Campus Connect"
                ]
                
                
                guard let imageData = imageSelected.jpegData(compressionQuality: 0.5) else {return}
                
//                let storageReference = Storage.storage().reference(forURL: "gs://campusconnect-85522.appspot.com")
//                let storageProfileReference = storageReference.child("profile").child(authData.user.uid)
                
                let storageProfile = Ref().storageSpecificProfile(uid: authData.user.uid)
                
                
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
                
                StorageService.savePhoto(username: username, uid: authData.user.uid, data: imageData, metadata: metadata, storageRef: storageProfile, dict: dict, onSuccess: {onSuccess()}, onError: {(errorMessage) in onError(errorMessage)})
                
            }
            
        }
        
    }
    
    func resetPassword(email: String, onSuccess: @escaping()->Void, onError: @escaping(_ errorMessage: String)->Void){
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error==nil{
                onSuccess()
            }
            else{
                onError(error!.localizedDescription)
            }
        }
    }
    
    func logOut(){
        do {
            try Auth.auth().signOut()
        }
        catch{
            ProgressHUD.showError(error.localizedDescription)
            return
        }
        (UIApplication.shared.delegate as! AppDelegate).configureInitialVC()
    }
    
    
    func observeUsers(onSuccess: @escaping(UserCompletion)){
        Ref().databaseUsers.observe(.childAdded){ (snapshot) in
            if let dict = snapshot.value as? Dictionary<String,Any> {
                if let user = User.transformUser(dict: dict){
                    onSuccess(user)
                }
                
            }
            
        }
    }
    
}

typealias  UserCompletion = (User)->Void
