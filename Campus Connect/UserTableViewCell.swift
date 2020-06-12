//
//  UserTableViewCell.swift
//  Campus Connect
//
//  Created by Rahul Bansal on 20/03/20.
//  Copyright © 2020 Rahul Bansal. All rights reserved.
//

import UIKit
class UserTableViewCell: UITableViewCell {

    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    var user : User!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatar.layer.cornerRadius = 30
        avatar.clipsToBounds = true
    }

    func loadData(_ user: User){
        self.user = user
        self.usernameLbl.text = user.username
        self.statusLbl.text = user.status
        self.avatar.loadImage(user.profileImageUrl)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
