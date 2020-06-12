//
//  SignUpViewController.swift
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

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var fullNameContainerView: UIView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordContainerView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    var image:UIImage? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()}
    
    func setupUI() {
        setupSignUpLabel()
        setupImageView()
        setupFullNameField()
        setupEmailField()
        setupPasswordField()
        setupSignUpButton()
        setupSignInButton()
    }
    
    @IBAction func closeButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
        self.validateValues()
        self.signUp(onSuccess: {
            (UIApplication.shared.delegate as! AppDelegate).configureInitialVC()
        }) { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
    }
}
