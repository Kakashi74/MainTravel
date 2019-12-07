//  BookTripVC.swift
//  MainTravel
//
//  Created by Ahmed on 12/4/19.
//  Copyright © 2019 AhmedDev. All rights reserved.


import UIKit

class BookTripVC: UIViewController {

 
    
    @IBOutlet weak var fullNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var phoneTxt:UITextField!
    @IBOutlet weak var numOfAdults: UITextField!
    @IBOutlet weak var numOfChild: UITextField!
    @IBOutlet weak var notes: UITextField!
    
    @IBOutlet weak var promoCodeTxt: UITextField!
    
    @IBOutlet weak var progressLbl: UIActivityIndicatorView!
    
             var loginModel : LoginModel?
             var userid = (Int)()
             var token = (String)()
             var trips = TripModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupView()
    }
    
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func bookNowBtnPressed(_ sender: Any) {
//        progressLbl.isHidden = false
//        progressLbl.startAnimating()
        guard let name = fullNameTxt.text?.trimmed , fullNameTxt.text?.trimmed != "" else {return}
        guard let email = emailTxt.text?.trimmed , emailTxt.text?.trimmed != "" else {return}
         guard let phone = phoneTxt.text , phoneTxt.text != "" else {return}
         guard let adults = numOfAdults.text , numOfAdults.text != "" else {return}
         guard let child = numOfChild.text , numOfChild.text != "" else {return}
         guard let note =  notes.text , notes.text != "" else {return}
        // guard let promocode = promoCodeTxt.text , promoCodeTxt.text != "" else {return}
        
 
        
        AuthServices.instance.bookTrip( tripId: trips.id, name: name, email: email, phone: phone, numofAdults: adults, numofChild: child, promoCode: trips.promo, note: note) { (Success) in
            if let succes =  Success["message"]{
  print(succes)
                //self.progressLbl.isHidden = true
            }
                //self.progressLbl.stopAnimating()
//            self.progressLbl.isHidden = true
//            self.progressLbl.stopAnimating()
        }
    }

 func setupView(){
         progressLbl.isHidden = true
           
    fullNameTxt.attributedPlaceholder = NSAttributedString(string: "enter your full name", attributes: [NSAttributedStringKey.foregroundColor : textPlaceHolderColor])

        emailTxt.attributedPlaceholder = NSAttributedString(string: "enter your email", attributes: [NSAttributedStringKey.foregroundColor : textPlaceHolderColor])
  
    
    phoneTxt.attributedPlaceholder = NSAttributedString(string: "enter your phone", attributes:
        [NSAttributedStringKey.foregroundColor : textPlaceHolderColor])
    
    numOfAdults.attributedPlaceholder = NSAttributedString(string: "Number of Adults", attributes: [NSAttributedStringKey.foregroundColor : textPlaceHolderColor])
   
    numOfChild.attributedPlaceholder = NSAttributedString(string: "Number of Child", attributes: [NSAttributedStringKey.foregroundColor : textPlaceHolderColor])

    notes.attributedPlaceholder = NSAttributedString(string: "Comments or notes", attributes: [NSAttributedStringKey.foregroundColor : textPlaceHolderColor])

    promoCodeTxt.attributedPlaceholder = NSAttributedString(string: "Enter Promo Code", attributes: [NSAttributedStringKey.foregroundColor : textPlaceHolderColor])

         let tap = UITapGestureRecognizer(target: self, action: #selector(handelTap))
           view.addGestureRecognizer(tap)
     }
    
    

   @objc func handelTap(){
       view.endEditing(true)
      }

    

}
