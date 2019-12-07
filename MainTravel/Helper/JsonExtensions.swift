//
//  File.swift
//  MainTravel
//
//  Created by Ahmed on 12/3/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import Foundation
import SwiftyJSON
  

extension JSON{
    
    var toBool: Bool? {
        
        
        if let bool = self.bool {return bool}
        if let int = self.toInt{
            if int == 0 {
                return false
            } else if int == 1 {
                return true
            }
        }
    return nil
    }
    
    
    var toInt: Int? {
        
        if let int = self.int {return int}
        if let string = self.string , let int = Int(string){
    return int
    }
    return nil
    }
    
}
