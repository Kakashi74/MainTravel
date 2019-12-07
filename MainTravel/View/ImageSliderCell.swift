//
//  ImageSliderCell.swift
//  MainTravel
//
//  Created by Ahmed on 11/30/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import UIKit

class ImageSliderCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var image : UIImage! {
        
        didSet{
            imageView.image = image
            
        }
    }
    
    
    
}
