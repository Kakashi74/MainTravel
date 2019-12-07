//
//  ViewController.swift
//  MainTravel
//
//  Created by Ahmed on 11/29/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import UIKit
import Network

class LoginVC: UIViewController {

    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    

    @IBOutlet weak var internetConnectionLbl: UILabel!
    
    var loginModel : LoginModel?
    var userid = (Int)()
    var token = (String)()
    
    @IBOutlet weak var progressLbl: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        connectionStatus()
    }


    
    @IBAction func loginBtnPressed(_ sender: Any) {
              progressLbl.isHidden = false
              progressLbl.startAnimating()
        guard let email = emailTxt.text?.trimmed , emailTxt.text != "" else {return}
        guard let password = passwordTxt.text?.trimmed , passwordTxt.text != "" else {return}
                    
        
        AuthServices.instance.loginUser(email: email, pass: password) { (Success) in
            if Success {
                
                self.loginModel = Success as? LoginModel
                self.userid = self.loginModel?.user_id ?? 0
                self.token = self.loginModel?.token ?? ""
                 guard let homevc = self.storyboard?.instantiateViewController(withIdentifier: "main") as? MainTravelHomeVC else {return}
                                                homevc.userid = self.userid
                                                homevc.token = self.token
                                               print(self.userid,"ahmed")
                                               print(self.token,"Token")
                                              self.present(homevc, animated: true, completion: nil)
            }
        }
        
        
        
        
//        AuthServices.instance.login(email: email, password: password) { (Success) in
//            if let succes =  Success["message"]{
//                print(succes)
//                self.loginModel = succes as? LoginModel
//                print(succes)
//                self.userid = self.loginModel?.user_id ?? 0
//                self.token = self.loginModel?.token ?? ""
//                guard let homevc = self.storyboard?.instantiateViewController(withIdentifier: "main") as? MainTravelHomeVC else {return}
//                                homevc.userid = self.userid
//                                homevc.token = self.token
//                               print(self.userid,"ahmed")
//                               print(self.token,"Token")
//                              self.present(homevc, animated: true, completion: nil)
//
//                          //  self.present(homevc, animated: true, completion: nil)
//                                 self.progressLbl.isHidden = true
//                                  self.progressLbl.stopAnimating()
//
//            }
//        }
    }
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
        guard let signupVC = storyboard?.instantiateViewController(identifier: "CreateAccountVC") as? CreateAccountVC else {return}
              present(signupVC, animated: true, completion: nil)

    }
    

       func setupView(){
          progressLbl.isHidden = true
           emailTxt.attributedPlaceholder = NSAttributedString(string: "enter your email", attributes: [NSAttributedStringKey.foregroundColor : textPlaceHolderColor])
           
           passwordTxt.attributedPlaceholder = NSAttributedString(string: "enter your password", attributes: [NSAttributedStringKey.foregroundColor : textPlaceHolderColor])
                 
           let tap = UITapGestureRecognizer(target: self, action: #selector(handelTap))
           view.addGestureRecognizer(tap)
       }
       
    @objc func handelTap(){
       view.endEditing(true)
       }

    func AlertMsg(msg: String){
            
            let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    //        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    let monitor = NWPathMonitor()
    func connectionStatus(){
        internetConnectionLbl.isHidden = true
        monitor.pathUpdateHandler = { path in
            sleep(1)
            if path.status == .satisfied {
                print("Connected")
                DispatchQueue.main.sync {
                    self.internetConnectionLbl.text = "Connected"
                    self.internetConnectionLbl.backgroundColor = .green
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 ){
                        self.internetConnectionLbl.isHidden = true
                    }
                }
            }
            else if path.status == .requiresConnection {
                print("Connecting")
                self.internetConnectionLbl.text = "connecting"
                   self.internetConnectionLbl.backgroundColor = .yellow
                   self.internetConnectionLbl.isHidden = false
                   DispatchQueue.main.asyncAfter(deadline: .now() + 2.0 ){
                       self.internetConnectionLbl.isHidden = true
                   }
            }
            else if path.status == .unsatisfied {
                print("Disconnected")
                DispatchQueue.main.sync {
                    self.internetConnectionLbl.text = "Disconnected"
                    self.AlertMsg(msg: "no internet connection")
                    self.internetConnectionLbl.backgroundColor = .red
                    self.internetConnectionLbl.isHidden = false
                }
            }
        }
        let queue = DispatchQueue(label:"queue")
        monitor.start(queue: queue)
    }
    
    
}

