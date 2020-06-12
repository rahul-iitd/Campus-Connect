//
//  SignUpViewController+UI.swift
//  Campus Connect
//
//  Created by Rahul Bansal on 16/02/20.
//  Copyright © 2020 Rahul Bansal. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import ProgressHUD

extension SignUpViewController {
    
    
    func signUp(onSuccess: @escaping()->Void, onError: @escaping(_ errorMessage: String)->Void) {
        
        Api.user.signUp(withUsername: self.fullNameTextField.text!, email: self.emailTextField.text!, password: self.passwordTextField.text!, image: self.image, onSuccess: {
            onSuccess()
        }) { (errorMessage) in
            onError(errorMessage)
        }
        
    }
    
    
    func validateValues() {
        guard let username = self.fullNameTextField.text , !username.isEmpty else {
            ProgressHUD.showError("Please enter an username")
            return
        }
        guard let email = self.emailTextField.text , !email.isEmpty else {
            ProgressHUD.showError("Please enter an email address")
            return
        }
        guard let password = self.passwordTextField.text , !password.isEmpty else {
            ProgressHUD.showError("Please enter a password")
            return
        }
    }
    
    func setupSignUpLabel(){
        
        let title = "Sign Up"
        
        let attributedText = NSMutableAttributedString(string: title,attributes: [NSAttributedString.Key.font:UIFont.init(name :"Didot",size : 28)!,
                                                                                  NSAttributedString.Key.foregroundColor:UIColor.black])
        
        
        signUpLabel.attributedText = attributedText
        
    }
    func setupImageView(){
        ImageView.layer.cornerRadius = 40
        ImageView.clipsToBounds = true
        ImageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        ImageView.addGestureRecognizer(gesture)
    }
    
    @objc func presentPicker(){
    	let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker,animated: true, completion: nil)
        
        
    }
    
    
    func setupFullNameField(){
        fullNameContainerView.layer.borderWidth = 1
        fullNameContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        fullNameContainerView.layer.cornerRadius = 3
        fullNameContainerView.clipsToBounds = true
        
        fullNameTextField.borderStyle = .none
        
        let placeHolder = NSAttributedString(string: "Full Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        fullNameTextField.attributedPlaceholder = placeHolder
        fullNameTextField.textColor = UIColor(red: 98/255, green: 98/255, blue: 98/255, alpha: 1)
        
    }
    func setupEmailField(){
        emailContainerView.layer.borderWidth = 1
        emailContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        emailContainerView.layer.cornerRadius = 3
        emailContainerView.clipsToBounds = true
        
        emailTextField.borderStyle = .none
        
        let placeHolder = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        emailTextField.attributedPlaceholder = placeHolder
        emailTextField.textColor = UIColor(red: 98/255, green: 98/255, blue: 98/255, alpha: 1)
        
    }
    func setupPasswordField(){
        
        passwordContainerView.layer.borderWidth = 1
        passwordContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        passwordContainerView.layer.cornerRadius = 3
        passwordContainerView.clipsToBounds = true
        
        passwordTextField.borderStyle = .none
        
        let placeHolder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        passwordTextField.attributedPlaceholder = placeHolder
        passwordTextField.textColor = UIColor(red: 98/255, green: 98/255, blue: 98/255, alpha: 1)
        
    }
    
    func setupSignUpButton(){
        signUpButton.setTitle("Sign Up", for: UIControl.State.normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        signUpButton.backgroundColor = UIColor.black
        signUpButton.layer.cornerRadius = 5
        signUpButton.clipsToBounds = true
        signUpButton.setTitleColor(.white, for: UIControl.State.normal)
    }
    
    func setupSignInButton(){
        let attributeText = NSMutableAttributedString(string: "Already have an account? ",attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16),                                                                                  NSAttributedString.Key.foregroundColor:UIColor(white: 0, alpha: 0.65)])
        
        
        let attributeSubText = NSMutableAttributedString(string: "Sign In",attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 18),NSAttributedString.Key.foregroundColor:UIColor.black])
        
        attributeText.append(attributeSubText)
        signInButton.setAttributedTitle(attributeText, for: UIControl.State.normal)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension SignUpViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            image = imageSelected
            ImageView.image = imageSelected
        }
        
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            image = imageOriginal
            ImageView.image = imageOriginal
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
