//
//  ForgotPasswordViewController.swift
//  Campus Connect
//
//  Created by Rahul Bansal on 16/02/20.
//  Copyright © 2020 Rahul Bansal. All rights reserved.
//

import UIKit
import ProgressHUD

class ForgotPasswordViewController: UIViewController {

    
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetPasswordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()
    }
    
    func setupUI() {
        
        setupEmailTextField()
        setupResetPasswordButton()
        
    }

    @IBAction func resetPasswordTapped(_ sender: Any) {
        guard let email = emailTextField.text, email != "" else {
            ProgressHUD.showError("Enter a valid email address for password reset")
            return
        }
        
        Api.user.resetPassword(email: email, onSuccess: {
            self.view.endEditing(true)
            ProgressHUD.showSuccess("We have send a password reset mail to you email address. Please check and follow the instructions in the mail.")
            self.navigationController?.popViewController(animated: true)
        }) { (errorMessage) in
            ProgressHUD.showError(errorMessage )
        }
        
    }
    

}
