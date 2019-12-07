//
//  PhotoCell.swift
//  MainTravel
//
//  Created by Ahmed on 12/3/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire

class PhotoCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var photo: Photo? {
        didSet{
            guard let photo = photo else {return}
           self.imageView.kf.indicatorType = .activity
            if let url = URL(string: photo.url){
                self.imageView.kf.setImage(with: url ,placeholder: UIImage(named: "placeholder")  , options: [.transition(ImageTransition.flipFromTop(0.5))])
            }
        }
    }
    
}
















