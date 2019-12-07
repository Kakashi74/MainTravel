//
//  RoundedButton.swift
//  MainTravel
//
//  Created by Ahmed on 11/29/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    
    @IBInspectable var cornerRadious : CGFloat = 5.0 {
           didSet {
               self.layer.cornerRadius = cornerRadious
           }
       }

       override func awakeFromNib() {
           self.setupView()
       }
       
       override func prepareForInterfaceBuilder() {
           super.prepareForInterfaceBuilder()
           self.setupView()
       }
       
       func setupView(){
           self.layer.cornerRadius = cornerRadious
           
       }


}
