//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Asset Ryskul on 9/7/20.
//  Copyright © 2020 Asset Ryskul. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func chooseAvatar_Pressed(_ sender: Any) {
    }
    
    @IBAction func generateBGColor_Pressed(_ sender: Any) {
    }
    
    @IBAction func closeButton_Pressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
    
    @IBAction func createAccountButton_Pressed(_ sender: Any) {
        guard let email = emailTxt.text , emailTxt.text != "" else {
            return
        }
        guard let password = passwordTxt.text , passwordTxt.text != "" else {
            return
        }
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if (success){
                print("user register")
            }
            else {
                print("smth wrong")
            }
        }
    }
}
