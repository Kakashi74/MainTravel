//
//  Photo.swift
//  MainTravel
//
//  Created by Ahmed on 12/3/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import UIKit
import SwiftyJSON

class Photo: NSObject {
        var id: Int
        var url: String
        var name: String
    
    init?(dict:[String : JSON]) {
        guard let id = dict["id"]?.toInt ,let name = dict["name"]?.string , let photo = dict["main_image"]?.string , !photo.isEmpty else {return nil}
        self.id = id
        self.name = name
        self.url = photo
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
}
