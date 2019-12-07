//
//  AuthServices.swift
//  MainTravel
//
//  Created by Ahmed on 11/29/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthServices{
    static let instance = AuthServices()
    
    
//    let defalut = UserDefaults.standard
//
//    var isLoggedIn: Bool {
//
//        get{
//            return defalut.bool(forKey: "isloggedin")
//        }
//        set {
//            defalut.set(newValue, forKey: "isloggedin")
//        }
//    }
//
//    var token: String{
//
//        get{
//            return defalut.string(forKey: "token")  as! String
//        }
//        set{
//            defalut.set(newValue , forKey: "token")
//        }
//    }
//
//    var userEmail: String{
//
//          get{
//              return defalut.string(forKey: "useremail")  as! String
//          }
//          set{
//              defalut.set(newValue , forKey: "useremail")
//          }
//      }
//
//
    
//    func register(email: String , password: String , handler: @escaping (_ Success: Bool) -> ()){
//
//        let text = email.lowercased()
//
//        let header = ["Content-Type":"application/josn; charset=utf-8"]
//        let body: [String: Any] = [
//            "email": text,
//            "password": password
//        ]
//
//
//        Alamofire.request(REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
//            if response.result.error == nil {
//                handler(true)
//            }else {
//                handler(false)
//                debugPrint(response.result.error as Any)
//            }
//        }
//
//    }
    
    func loginUser(email: String, pass: String , handler: @escaping(_ Success: Bool) -> ()){
        
        let text = email.lowercased()
        let params :[String : Any] = [
            "email": email,
            "password": pass
        ]
        
        
        Alamofire.request(LOGIN_URL, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result{
                
            case .failure(let error):
                print(error)
                handler(false)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                let api_token = json["token"].string
               let api = Helper.saveApiToken(token: api_token!)
            }
            
        }
        
    }
    
    
    func login(email: String , password: String , handler: @escaping (_ Success: [String:Any]) -> ()){
        
        let text = email.lowercased()
       // let header = ["Content-Type":"application/json; charset=utf-8"]
        let body: [String: Any] = [
            "email": text,
            "password": password
        ]
        
        Alamofire.request(LOGIN_URL, method: .post, parameters: body, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let Error):
                print(Error)
                
                case .success(let value):
                      // print(value)
                       let json = JSON(value)
                       handler(value as! [String : Any])
                      // var login : LoginModel?
                       var login : LoginModel?
                if let api_token = json["token"].string{
               // --->     login?.token = api_token
              //      let api = Helper.saveApiToken(token: api_token)
                    print("here is the \(api_token)")
//                    login?.token = api_token
//                    Helper.saveApiToken(token: api_token)
//                    login?.user_id = json["user_id"].int ??  10
                    //=   Helper.saveApiToken(token: api_token)
                }else {
                    print("error token")
                       }
                    if let userid = json["user_id"].int{
                 // ----->       login?.user_id = userid
                     //   let id = Helper.saveUserId(userid: userid)
                        print("here is the \(userid)")
                       }else {
                        print("error  id ")
                }
//                var login = LoginModel()
//                if let user_id = json["user_id"].int{
//                login.user_id = user_id
                }
                
            }
        }
        

    
    
    func Register(name: String , email: String , phone: String , password:String ,handler: @escaping (_ Success: [String:Any]) -> ()){
         let text = email.lowercased()
        
        let params: [String: Any] = ["name":name,
        "email": text,
        "phone":phone,
        "password": password]

       Alamofire.request(REGISTER, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in

        switch response.result {
            
        case .failure(let error):
           // handler(false)
            print(error)
            
        case .success(let value):
            print(value)
            let json = JSON(value) 
            handler(value as! [String : Any])
            if let api_token = json["token"].string {
                Helper.saveApiToken(token: api_token)
          //      handler(true)
            }
        }
       }

    }
    
    
    
    func logOut( handler: @escaping (_ Success: [String:Any]) -> ()){
        
        let api_token = Helper.getApiToken()
        let userid = Helper.getUserId()
        let params: [String: Any] = ["user_id" : userid , "token" :api_token]
        
        
        Alamofire.request(USER_LOGOUT, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
           
            switch response.result {
                
            case .failure(let error):
                print(error)
                
            case .success(let value):
                 print(value)
        }
        
    }
    }
    
    
    
    
    func getGallery(handler: @escaping (_ error: Error? , _ photo:[Photo]?) -> Void){
        
        
        Alamofire.request(GALLERY_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
                case .failure(let error):
                handler(error , nil)
               case .success(let value):
                let json = JSON(value)
                guard let data = json["data"].array else {handler(nil , nil)
                    return
                }
                
                var photos = [Photo]()
                data.forEach({
                    if let dict = $0.dictionary ,let photo = Photo(dict: dict){
                        photos.append(photo)
                    }
                })
                handler(nil , photos)
            }
        }
    }
    
    
    func getTrips( handler: @escaping (_ error: Error? , _ trip:[TripModel]?) -> Void){
        Alamofire.request(TRIP_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
          
            switch response.result {
                
            case .failure(let error):
               handler(error , nil)
                
                
            case .success(let value):
                let json = JSON(value)
                
                guard let dataArr = json["data"].array  else {
                handler(nil , nil)
                    return
                }
                
                var trip = [TripModel]()
                for data in dataArr {
                    guard let data = data.dictionary  else {return}
                    
                    let mTrip = TripModel()
                    
                    mTrip.id = data["id"]?.int ?? 0
                    mTrip.name  = data["name"]?.string ?? "error"
                    mTrip.desc = data["main_description"]?.string  ?? "error"
                    mTrip.salary = data["salary"]?.string ?? "error"
                    mTrip.fromDate = data["from"]?.string ?? "error"
                    mTrip.toDate = data["to"]?.string ?? "error"
                    mTrip.promo = data["promo"]?.string ?? "error"
                    
                    trip.append(mTrip)
                }
                handler(nil , trip)
                            }
        
    }
}
    
    func bookTrip(tripId: Int,name: String , email: String , phone: String ,numofAdults: String , numofChild: String , promoCode: String , note: String  , handler: @escaping (_ Success: [String:Any]) -> ()){
        
        
        guard let api_token = Helper.getApiToken() else {return}
        guard let userid = Helper.getUserId() else {return}
        let params : [String: Any] = [
            "user_id": userid ,
            "token": api_token,
            "trip_id":tripId ,
            "promo": promoCode,
            "name": name,
            "email": email,
            "mobile": phone ,
            "adults": numofAdults,
            "child": numofChild ,
            "note": note,
        ]
        
        Alamofire.request(BOOK_TRIP_URL, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
             switch response.result {
                       
                   case .failure(let error):
                      
                       print(error)
                       
                   case .success(let value):
                       print(value)
                  }
    }
}

}
 
    
    
    /*
     "data": {
     "information": [
         {
     "id": 22,
     "name": "Aswan",
     "name_ar": "أسوان",
     "salary": "350",
     "from": "2020-01-01",
     "to": "2020-01-15",
     "main_image": "https://egypto-mania.com/uploads/1668620315.jpg",
     "main_description": "A wonderful exclusive tour for ‘Bird Watchers’ on this 3 hour Bird Watching Tour in Aswan with Mr Mohamed Arabi known as the Birdman of Aswan. Take a scenic ride in a felucca around the Cataract Islands to see up to many species of local birds and pretty flora and fauna in a most delightful environment.",
     "main_description_ar": "جولة حصرية رائعة لـ \"Bird Watchers\" في جولة مراقبة الطيور التي مدتها 3 ساعات في أسوان مع السيد محمد عرابي المعروف باسم Birdman of Aswan. يمكنك القيام برحلة ذات المناظر الخلابة في فيلوكا حول جزر الكاتاراكت لمشاهدة ما يصل إلى العديد من أنواع الطيور المحلية والنباتات والحيوانات الجميلة في بيئة ممتعة للغاية.",
     "promo": "mahmoud",
     "discount": "10",
     "endpromo": "2020-01-01",
     "type": "tour",
     "created_at": "2019-11-19 17:09:38",
     "updated_at": "2019-11-19 18:21:32"
     */
    
    
    
    
//    func postTripInfo(trip_id: Int ,handler: @escaping (_ Success: Bool) -> () ){
//        
//        let header = ["Content-Type":"application/josn; charset=utf-8"]
//               let body: [String: Any] = [
//                   "trip_id": trip_id]
//                  
//        
//        Alamofire.request(TRIP_INFO, method: .post, parameters: body, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
//            switch response.result {
//                
//            case .failure(let error):
//               handler(false)
//                
//                
//            case .success(let value):
//                let json = JSON(value)
//                
//                
//                
//                
//        }
//            
//    }
//    }
//}
