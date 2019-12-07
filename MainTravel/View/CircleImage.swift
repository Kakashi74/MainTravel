//
//  CircleImage.swift
//  MainTravel
//
//  Created by Ahmed on 12/1/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import UIKit

import UIKit
@IBDesignable
class CircleImage: UIImageView {
    
    override func awakeFromNib() {
        setupView()
    }
    func setupView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
        
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
}
