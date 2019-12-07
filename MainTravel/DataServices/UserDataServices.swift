//
//  UserDataServices.swift
//  MainTravel
//
//  Created by Ahmed on 11/29/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import Foundation

class UserDataServices{
    
    static let instance = UserDataServices()
    
    public private(set) var id = ""
    public private(set) var phone = ""
    public private(set) var password = ""
    public private(set) var email = ""
    public private(set) var name = ""
 

    
    func setData(id: String, phone: String , password: String , email: String , name: String){
        self.id = id
        self.phone = phone
        self.password = password
        self.email = email
        self.name = name
        
    }

}
