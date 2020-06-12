//
//  ViewController+UI.swift
//  Campus Connect
//
//  Created by Rahul Bansal on 27/01/20.
//  Copyright © 2020 Rahul Bansal. All rights reserved.
//

import UIKit

extension ViewController{
    
    func setupHeaderTitle(){
        let title = "Create a new account"
        let subTitle = "\n\nDeveloped by Group 3"
        
        let attributedText = NSMutableAttributedString(string: title,attributes: [NSAttributedString.Key.font:UIFont.init(name :"Didot",size : 28)!,
          NSAttributedString.Key.foregroundColor:UIColor.black])
        
        let attributedSubTitle = NSMutableAttributedString(string: subTitle,attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14),
           NSAttributedString.Key.foregroundColor:UIColor(white: 0, alpha: 0.45)])
        
        attributedText.append(attributedSubTitle)
        
        titleLabel.numberOfLines = 0
        titleLabel.attributedText = attributedText
    }
    
    func setupOrLabel(){
        orLabel.text = "Or"
        orLabel.font = UIFont.boldSystemFont(ofSize: 16)
        orLabel.textColor = UIColor(white: 0, alpha: 0.45)
        orLabel.textAlignment = .center
    }
    
    func setupTermsLabel(){
        let attributeTermsText = NSMutableAttributedString(string: "By clicking \"Create a new account\" you agree to our ",attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14),
          NSAttributedString.Key.foregroundColor:UIColor(white: 0, alpha: 0.65)])
        
        
        let attributeSubTermsText = NSMutableAttributedString(string: "Terms of Service.",attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14),
          NSAttributedString.Key.foregroundColor:UIColor(white: 0, alpha: 0.65)])
        
        attributeTermsText.append(attributeSubTermsText)
        
        termsOfServiceLabel.attributedText = attributeTermsText
        termsOfServiceLabel.numberOfLines = 0
    }
    
    func setupFacebookButton(){
        signInFacebookButton.setTitle("Sign in with Facebook", for: UIControl.State.normal)
        signInFacebookButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        signInFacebookButton.backgroundColor = UIColor(red: 58/255, green: 84/255, blue: 159/255, alpha: 1)
        signInFacebookButton.layer.cornerRadius = 5
        signInFacebookButton.clipsToBounds = true
        
        signInFacebookButton.setImage(UIImage(named:"icon-facebook"),for: UIControl.State.normal)
        signInFacebookButton.imageView?.contentMode = .scaleAspectFit
        signInFacebookButton.tintColor = .white
        signInFacebookButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: -15, bottom: 12, right: 0)
    }
    
    
    func setupGoogleButton(){
        signInGoogleButton.setTitle("Sign in with Google", for: UIControl.State.normal)
        signInGoogleButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        signInGoogleButton.backgroundColor = UIColor(red: 223/255, green: 74/255, blue: 50/255, alpha: 1)
        signInGoogleButton.layer.cornerRadius = 5
        signInGoogleButton.clipsToBounds = true
        
        signInGoogleButton.setImage(UIImage(named:"icon-google"),for: UIControl.State.normal)
        signInGoogleButton.imageView?.contentMode = .scaleAspectFit
        signInGoogleButton.tintColor = .white
        signInGoogleButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: -35, bottom: 12, right: 0)
    }
    
    func setupCreateAccountButton(){
        createAccountButton.setTitle("Create a new account", for: UIControl.State.normal)
        createAccountButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        createAccountButton.backgroundColor = UIColor.black
        createAccountButton.layer.cornerRadius = 5
        createAccountButton.clipsToBounds = true
    }
}
