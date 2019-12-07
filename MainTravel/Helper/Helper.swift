//
//  Helper.swift
//  MainTravel
//
//  Created by Ahmed on 12/3/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import UIKit

class Helper: NSObject {
    
    /*
     class func isLoggedIn() -> Bool {
         
         if let _ = UserDefaults.standard.object(forKey: "email") {
            
             return true
         }
             
         else {
             
             return false
         }
         
     }
     */
    
    class func restartApp(){
        guard let window = UIApplication.shared.keyWindow else {return}
    
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var vc : UIViewController
        
        if getApiToken() == nil {
            vc = sb.instantiateInitialViewController()!
            
        } else {
            vc = sb.instantiateViewController(identifier: "main")
        }
        
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
    class func saveApiToken(token: String){
        let def = UserDefaults.standard
        def.setValue(token, forKey: "api_token")
        def.synchronize()
        
        restartApp()
    }
    
    
    class func getApiToken() -> String? {
        let def = UserDefaults.standard
        return  def.object(forKey: "api_token") as? String
          
    }
    
    class func saveUserId(userid: Int){
        let def = UserDefaults.standard
        def.set(userid, forKey: "user_id")
        def.synchronize()
    }
    
    class func getUserId() -> Int? {
        let def = UserDefaults.standard
        return  def.object(forKey: "user_id") as? Int
        
    }
    class func removeCashedData() {
           
           UserDefaults.standard.removeObject(forKey: "api_token")
           UserDefaults.standard.removeObject(forKey: "user_id")
       }
}
