//
//  CircleImageView.swift
//  Smack
//
//  Created by Asset Ryskul on 9/13/20.
//  Copyright © 2020 Asset Ryskul. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImageView: UIImageView {
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.layer.frame.width / 2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
}
