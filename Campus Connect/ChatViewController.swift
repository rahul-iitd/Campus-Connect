//
//  ChatViewController.swift
//  Campus Connect
//
//  Created by Rahul Bansal on 26/05/20.
//  Copyright © 2020 Rahul Bansal. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation
class ChatViewController: UIViewController {
	
    var imagePartner: UIImage!
    var avatarImageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
    var topLabel : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    var partnerUsername: String!
    var placeholderLbl = UILabel()
    var partnerId: String!
    var picker = UIImagePickerController()
    var messages = [Message]()
    
    @IBOutlet weak var mediaButton: UIButton!
    @IBOutlet weak var audioButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var inputTextView: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPicker()
        setupInputContainer()
		setUpNavigationBar()
        setupTableView()
        observeMessages()
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    @IBAction func sendBtnDidTapped(_ sender: Any) {
        if let text = inputTextView.text,text != "" {
            inputTextView.text = ""
            self.textViewDidChange(inputTextView)
            sendToFirebase(dict:["text":text as Any])
        }
    }
    @IBAction func mediaBtnDidTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Campus Connect", message: "Select source", preferredStyle: UIAlertController.Style.actionSheet)
        let camera = UIAlertAction(title: "Take a picture", style: UIAlertAction.Style.default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            	self.picker.sourceType = .camera
                self.present(self.picker,animated: true, completion: nil)}
            else{
                print("Not Available")
            }
            
        }
        
        let library = UIAlertAction(title: "Select an Image or a Video", style: UIAlertAction.Style.default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            	self.picker.sourceType = .photoLibrary
                self.picker.mediaTypes = [String(kUTTypeMovie), String(kUTTypeImage)]
                self.present(self.picker,animated: true, completion: nil)}
            else {
                print("Not Available")
            }
            
        }
        
        let videoCamera = UIAlertAction(title: "Take a Video", style: UIAlertAction.Style.default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                self.picker.sourceType = .camera
                self.picker.mediaTypes = [String(kUTTypeMovie)]
                self.picker.videoExportPreset = AVAssetExportPresetPassthrough
                self.picker.videoMaximumDuration = 60
                self.present(self.picker,animated: true, completion: nil)}
            else {
                print("Not Available")
            }
            
        }
        
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(camera)
        alert.addAction(library)
        alert.addAction(videoCamera)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
}


