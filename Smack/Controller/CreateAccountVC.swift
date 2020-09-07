//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Asset Ryskul on 9/7/20.
//  Copyright © 2020 Asset Ryskul. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func closeButton_Pressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
    
}
