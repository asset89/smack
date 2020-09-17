//
//  ProfileVC.swift
//  Smack
//
//  Created by Asset Ryskul on 9/17/20.
//  Copyright © 2020 Asset Ryskul. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    //Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func logoutButton_Pressed(_ sender: Any) {
        UserDataService.instance.logout()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGED, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeButton_Pressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        nameLabel.text = UserDataService.instance.name
        emailLabel.text = UserDataService.instance.email
        profileImageView.image = UIImage(named: UserDataService.instance.avatarName)
        profileImageView.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        
        let closeTouch = UITapGestureRecognizer()
        closeTouch.addTarget(self, action: #selector(ProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
