//
//  MessageCell.swift
//  Smack
//
//  Created by Asset Ryskul on 9/25/20.
//  Copyright © 2020 Asset Ryskul. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var userImgView: CircleImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var messageBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(message: Message) {
        messageBodyLabel.text = message.message
        usernameLabel.text = message.userName
        //timestampLabel.text = message.timestamp
        userImgView.image = UIImage(named: message.userAvatar)
        userImgView.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
    }

}
