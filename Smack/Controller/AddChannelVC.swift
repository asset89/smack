//
//  AddChannelVC.swift
//  Smack
//
//  Created by Asset Ryskul on 9/19/20.
//  Copyright © 2020 Asset Ryskul. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }

    @IBAction func createChannel_Pressed(_ sender: Any) {
        guard let channelName = nameTxt.text , nameTxt.text != "" else {return}
        guard let channelDescription = descriptionTxt.text , descriptionTxt.text != "" else {return}
        SocketServices.instance.addChannel(channelName: channelName, channelDescription: channelDescription) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        
        nameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder])
        descriptionTxt.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder])
        
        let closeTouch = UITapGestureRecognizer()
        closeTouch.addTarget(self, action: #selector(ProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    

}
