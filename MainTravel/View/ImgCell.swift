//
//  ImgCell.swift
//  MainTravel
//
//  Created by Ahmed on 12/2/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import UIKit

class ImgCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image : UIImage! {
           
           didSet{
               imageView.image = image
               
           }
       }
       
    
}
