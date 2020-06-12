//
//  SignInViewController+UI.swift
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

extension SignInViewController {
    
    func setupSignInLabel(){
        let title = "Sign In"
        
        let attributedText = NSMutableAttributedString(string: title,attributes: [NSAttributedString.Key.font:UIFont.init(name :"Didot",size : 28)!,NSAttributedString.Key.foregroundColor:UIColor.black])
        signInLabel.attributedText = attributedText
        
    }
    func setupEmailTextField(){
        emailContainerView.layer.borderWidth = 1
        emailContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        emailContainerView.layer.cornerRadius = 3
        emailContainerView.clipsToBounds = true
        
        emailTextField.borderStyle = .none
        
        let placeHolder = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        emailTextField.attributedPlaceholder = placeHolder
        emailTextField.textColor = UIColor(red: 98/255, green: 98/255, blue: 98/255, alpha: 1)
    }
    func setupPasswordTextField(){
        passwordContainerView.layer.borderWidth = 1
        passwordContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        passwordContainerView.layer.cornerRadius = 3
        passwordContainerView.clipsToBounds = true
        
        passwordTextField.borderStyle = .none
        
        let placeHolder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        passwordTextField.attributedPlaceholder = placeHolder
        passwordTextField.textColor = UIColor(red: 98/255, green: 98/255, blue: 98/255, alpha: 1)
    }
    func setupSignInButton(){
        signInButton.setTitle("Sign In", for: UIControl.State.normal)
        signInButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        signInButton.backgroundColor = UIColor.black
        signInButton.layer.cornerRadius = 5
        signInButton.clipsToBounds = true
        signInButton.setTitleColor(.white, for: UIControl.State.normal)
    }
    func setupSingUpButton(){
        let attributeText = NSMutableAttributedString(string: "Don't have an account? ",attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16),                                                                                  NSAttributedString.Key.foregroundColor:UIColor(white: 0, alpha: 0.65)])
        
        
        let attributeSubText = NSMutableAttributedString(string: "Sign Up",attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 18),NSAttributedString.Key.foregroundColor:UIColor.black])
        
        attributeText.append(attributeSubText)
        signUpButton.setAttributedTitle(attributeText, for: UIControl.State.normal)
    }
    
    func validateValues() {
        guard let email = self.emailTextField.text , !email.isEmpty else {
            ProgressHUD.showError("Please enter an email address")
            return
        }
        guard let password = self.passwordTextField.text , !password.isEmpty else {
            ProgressHUD.showError("Please enter a password")
            return
        }
    }
    
    func signIn(onSuccess: @escaping()->Void, onError: @escaping(_ errorMessage: String)->Void) {
        ProgressHUD.show("Signing In")
        Api.user.signIn(email: self.emailTextField.text!, password: self.passwordTextField.text!, onSuccess: {
            ProgressHUD.dismiss()
            onSuccess()
        }) { (errorMessage) in
            onError(errorMessage)
        }
        
        
    }

    
}
