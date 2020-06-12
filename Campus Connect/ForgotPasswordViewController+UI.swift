//
//  ForgotPasswordViewController+UI.swift
//  Campus Connect
//
//  Created by Rahul Bansal on 16/02/20.
//  Copyright © 2020 Rahul Bansal. All rights reserved.
//

import UIKit

extension ForgotPasswordViewController {
    
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
    func setupResetPasswordButton(){
        resetPasswordButton.setTitle("Reset My Password", for: UIControl.State.normal)
        resetPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        resetPasswordButton.backgroundColor = UIColor.black
        resetPasswordButton.layer.cornerRadius = 5
        resetPasswordButton.clipsToBounds = true
        resetPasswordButton.setTitleColor(.white, for: UIControl.State.normal)
    }
    
}
