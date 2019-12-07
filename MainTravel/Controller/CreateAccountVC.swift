//
//  CreateAccountVC.swift
//  MainTravel
//
//  Created by Ahmed on 11/29/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var userNameTxt: UITextField!
    
    @IBOutlet weak var userEmailTxt: UITextField!
    
    @IBOutlet weak var userPhoneTxt: UITextField!
    
    @IBOutlet weak var userPasswordTxt: UITextField!
    
    
    @IBOutlet weak var progressLbl: UIActivityIndicatorView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
           setupView()
    }
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
               progressLbl.isHidden = false
               progressLbl.startAnimating()
           
        guard let email = userEmailTxt.text?.trimmed , userEmailTxt.text != "" else {return}
        guard let password = userPasswordTxt.text?.trimmed , userPasswordTxt.text != "" else {return}
        guard let name = userNameTxt.text?.trimmed , userNameTxt.text != "" else {return}
        guard let phone = userPhoneTxt.text?.trimmed , userPhoneTxt.text != "" else {return}
        
        
        AuthServices.instance.Register(name: name, email: email, phone: phone, password: password) { (Success) in
            if let succes =  Success["message"]{
                print(succes)
//             guard let homeVC = self.storyboard?.instantiateViewController(identifier: "main") as? MainTravelVC else {return}
//                           self.present(homeVC, animated: true, completion: nil)
//                                 self.progressLbl.isHidden = true
//                                 self.progressLbl.stopAnimating()
//
//                                 NotificationCenter.default.post(name: NOTIF_USER_CHANGE,object: nil)
              
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "main") as! MainTravelHomeVC
                self.present(vc, animated: true, completion: nil)
                
                
                
            }
            }
        }
    
    

       func setupView(){
           progressLbl.isHidden = true
        
           userNameTxt.attributedPlaceholder = NSAttributedString(string: "enter your name", attributes: [NSAttributedStringKey.foregroundColor : textPlaceHolderColor])
           
           userEmailTxt.attributedPlaceholder = NSAttributedString(string: "enter your email", attributes: [NSAttributedStringKey.foregroundColor : textPlaceHolderColor])
                 
           userPhoneTxt.attributedPlaceholder = NSAttributedString(string: "enter your phone", attributes: [NSAttributedStringKey.foregroundColor : textPlaceHolderColor])
                
        userPasswordTxt.attributedPlaceholder = NSAttributedString(string: "enter your password ... at least 6 charechters", attributes: [NSAttributedStringKey.foregroundColor : textPlaceHolderColor])
                             
           
           let tap = UITapGestureRecognizer(target: self, action: #selector(handelTap))
           view.addGestureRecognizer(tap)
       }
       
    @objc func handelTap(){
       view.endEditing(true)
       }

    

}
