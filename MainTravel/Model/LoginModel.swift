//
//  LoginModel.swift
//  MainTravel
//
//  Created by Ahmed on 12/4/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import UIKit
/*
 class LoginModel: NSObject {
 
 
 
 
 */
struct LoginModel: Decodable {
    
    var user_id: Int?
    var token: String?
    var message : String?

}
