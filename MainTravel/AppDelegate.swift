//
//  AppDelegate.swift
//  MainTravel
//
//  Created by Ahmed on 11/29/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         
//        if let api_token = Helper.getApiToken() != nil {
//         let Tap = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "main")
//         window?.rootViewController = Tap
//            
//        }
         
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
   /*
    func checkLogin(){
        if Helper.isLoggedIn(){
            let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            
            let nav = UINavigationController(rootViewController: viewController)
            self.window?.rootViewController = nav
        }else{
            let viewController = UIStoryboard.init(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            let nav = UINavigationController(rootViewController: viewController)
            self.window?.rootViewController = nav
        }
    }
*/
    

}

