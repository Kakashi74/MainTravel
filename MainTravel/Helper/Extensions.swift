//
//  Extensions.swift
//  MainTravel
//
//  Created by Ahmed on 11/29/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import UIKit

extension UIView {
    
    
    func bindToKeyboard(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardChange), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    
    @objc func keyBoardChange (_ notification : NSNotification){
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve  = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let beginFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endFrame =  (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let change = endFrame.origin.y - beginFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y  +=  change
        }, completion: nil)
  
    
    }
    
}



extension String {
    
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    func isValidEmail() -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailTest.evaluate(with: self)
       }
       
       func isValidPassword() -> Bool {
           
           if self.count >= 8 {
               return true
           }
           
           return false
       }
       
       func extractTime() -> String {
           
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
           let date = formatter.date(from: self)
           
         //   print(date)
           
           formatter.dateFormat = "yyyy-MM-dd HH:mm"
           let stringDate = formatter.string(from: date!).capitalized
           
           //  print(stringDate)
           return stringDate
       }
       
       public func localized() -> String {
           return NSLocalizedString(self, comment: "")
       }
       
}

