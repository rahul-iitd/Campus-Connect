//
//  InboxTableViewCell.swift
//  Campus Connect
//
//  Created by Rahul Bansal on 20/06/20.
//  Copyright © 2020 Rahul Bansal. All rights reserved.
//

import UIKit

class InboxTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
