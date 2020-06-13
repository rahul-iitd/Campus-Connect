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
    
    func observeMessages(){
        Api.message.receiveMessage(from: Api.user.currentUserId, to: partnerId) { (message) in
            self.messages.append(message)
            self.sortMessages()
        }
        Api.message.receiveMessage(from: partnerId, to: Api.user.currentUserId) { (message) in
            self.messages.append(message)
            self.sortMessages()
        }
    }
    
    func sortMessages(){
        messages = messages.sorted(by: {$0.date<$1.date})
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setupPicker(){
        picker.delegate = self
    }
    
    func setupTableView(){
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupInputContainer(){
        let mediaImg = UIImage(named: "attachment_icon")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        mediaButton.setImage(mediaImg, for: UIControl.State.normal)
        mediaButton.tintColor = .lightGray
        
        let micImg = UIImage(named: "mic")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        audioButton.setImage(micImg, for: UIControl.State.normal)
        audioButton.tintColor = .lightGray
        
        setupInputTextView()
    }
    
    func setupInputTextView(){
        
        inputTextView.delegate = self
        placeholderLbl.isHidden = false
        
        let placeholderX: CGFloat = self.view.frame.size.width/75
        let placeholderY: CGFloat =  0
        let placeholderWidth:CGFloat = inputTextView.bounds.width-placeholderX
        
        let placeholderHeight:CGFloat = inputTextView.bounds.height
        
        let placeholderFontSize = self.view.frame.size.width/25
        
        placeholderLbl.frame = CGRect(x: placeholderX, y: placeholderY, width: placeholderWidth, height: placeholderHeight)
        placeholderLbl.text = "Write Something"
        placeholderLbl.font = UIFont(name: "HelveticaNeue", size: placeholderFontSize)
        placeholderLbl.textColor = .lightGray
        placeholderLbl.textAlignment = .left
        inputTextView.addSubview(placeholderLbl)
        
        
    }
    
    func setUpNavigationBar(){
        navigationItem.largeTitleDisplayMode = .never
        let containView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        avatarImageView.image = imagePartner
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.layer.cornerRadius = 18
        avatarImageView.clipsToBounds = true
        containView.addSubview(avatarImageView)
        
        let rightBarButton = UIBarButtonItem(customView: containView)
        navigationItem.rightBarButtonItem = rightBarButton
        
        topLabel.textAlignment = .center
        topLabel.numberOfLines = 0
        
        let attributed = NSMutableAttributedString(string: partnerUsername+"\n",
            attributes:[.font: UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.black] )
        
        attributed.append(NSAttributedString(string:"Active",
                attributes:[.font: UIFont.systemFont(ofSize: 13),.foregroundColor:UIColor.green]))
        topLabel.attributedText = attributed
        
        self.navigationItem.titleView = topLabel
        
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
    
    func sendToFirebase(dict: Dictionary<String,Any>){
        let date : Double = Date().timeIntervalSince1970
        var value = dict
        value["from"] = Api.user.currentUserId
        value["to"] = partnerId
        value["date"] = date
        value["read"] = true
        
        Api.message.sendMessage(from: Api.user.currentUserId, to: partnerId, value: value)
    }
    
}

extension ChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let spacing = CharacterSet.whitespacesAndNewlines
        if !textView.text.trimmingCharacters(in: spacing).isEmpty{
            let text = textView.text.trimmingCharacters(in: spacing)
            sendButton.isEnabled = true
            sendButton.setTitleColor(.black, for: UIControl.State.normal)
            placeholderLbl.isHidden = true
        }
        else{
            sendButton.isEnabled = false
            sendButton.setTitleColor(.lightGray, for: UIControl.State.normal)
            placeholderLbl.isHidden = false
        }
    }
}

extension ChatViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            handleVideoSelectedForUrl(videoUrl)
        }
        else{
            handleVideoSelectedForInfo(info)
        }
    }
    
    func handleVideoSelectedForUrl(_ url: URL){
        let videoName = NSUUID().uuidString
        StorageService.saveVideoMessages(url: url, id: videoName, onSuccess: { (anyValue) in
            if let dict = anyValue as? [String:Any]{
                self.sendToFirebase(dict: dict)
            }
        }) { (errorMessage) in
            
        }
        self.picker.dismiss(animated: true, completion: nil)
    }
    
    func handleVideoSelectedForInfo(_ info: [UIImagePickerController.InfoKey : Any]){
        var selectedImageFromPicker: UIImage?
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            selectedImageFromPicker = imageSelected
        }
        
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
           	selectedImageFromPicker = imageOriginal
        }
        let imageName = NSUUID().uuidString
        StorageService.savePhotoMessage(image: selectedImageFromPicker, id: imageName, onSuccess: { (anyValue) in
            if let dict = anyValue as? [String:Any]{
                self.sendToFirebase(dict: dict)
            }
        }) { (errorMessage) in
            print("Not done")
        }
        self.picker.dismiss(animated: true, completion: nil)
    }
}



extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell") as! MessageTableViewCell
        cell.configureCell(uid: Api.user.currentUserId, message: messages[indexPath.row], image: imagePartner)
        cell.playButton.isHidden = messages[indexPath.row].videoUrl == ""
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height : CGFloat = 0
        let message = messages[indexPath.row]
        let text = message.text
        if !text.isEmpty{
            height = text.estimateFrameForText(text).height + 60
        }
        
        let heightMessage = message.height
        let widthMessage = message.width
        
        if heightMessage != 0 , widthMessage != 0 {
            height = CGFloat(heightMessage/widthMessage * 250)
        }
        
        return height
    }
    
    
}
