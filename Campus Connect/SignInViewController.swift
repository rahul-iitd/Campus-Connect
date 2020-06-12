//
//  SignInViewController.swift
//  Campus Connect
//
//  Created by Rahul Bansal on 16/02/20.
//  Copyright © 2020 Rahul Bansal. All rights reserved.
//

import UIKit
import ProgressHUD

class SignInViewController: UIViewController {

    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordContainerView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()
    }
    
    func setupUI(){
        
        setupSignInLabel()
        setupEmailTextField()
        setupPasswordTextField()
        setupSignInButton()
        setupSingUpButton()
        
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
        self.validateValues()
        self.signIn(onSuccess: {
            (UIApplication.shared.delegate as! AppDelegate).configureInitialVC()
        }) { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
    }
    
    @IBAction func closeButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
