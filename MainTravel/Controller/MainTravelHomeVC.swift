//
//  MainTravelHomeVC.swift
//  MainTravel
//
//  Created by Ahmed on 12/5/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import UIKit
import Network

class MainTravelHomeVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tripNameLbl: UILabel!
    @IBOutlet weak var tripDescLbl: UILabel!
    
    
    var trips = [TripModel]()
    
        var loginModel : LoginModel?
        var userid = (Int)()
        var token = (String)()
       
    var currentIndex = 0
        var time: Timer?
        var imgArray = [
            UIImage(named: "slide1"),
            UIImage(named: "slide2"),
            UIImage(named: "slide3")
        ]
    
    func logOutAlertMsg(msg: String){
            
            let alert = UIAlertController(title: "Are You Sure You Want To LogOut", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "yes", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                collectionView.delegate = self
                collectionView.dataSource = self
                pageControl.numberOfPages = imgArray.count
                  startTime()
                  setupViewData()
    }
    
    func setupViewData(){
      
        
        AuthServices.instance.getTrips { (error:
            Error?, trips: [TripModel]?) in
             
            if let trips = trips {
                self.trips = trips
                self.tripNameLbl.text = trips[0].name
                self.tripDescLbl.text = trips[0].desc
                
            }
        }
        
    }
    
    func startTime(){
        time = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timeAction), userInfo: nil, repeats: true)
       }
       
       @objc func timeAction(){
           
           let mainPosition = (currentIndex < imgArray.count - 1) ? currentIndex + 1 : 0
           collectionView.scrollToItem(at:IndexPath(item: mainPosition, section: 0), at: .centeredHorizontally, animated: true)
       }
    
    
    
    @IBAction func logOutBtnWasPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func logOutBtnPressed(_ sender: Any) {
        
//        AuthServices.instance.logOut() { (Success) in
//            if let succes =  Success["message"]{
//                Helper.removeCashedData()
//               self.dismiss(animated: true, completion: nil)
//
//        }}
           self.dismiss(animated: true, completion: nil)
    
        
    }
    
    @IBAction func TripsBtnPressed(_ sender: Any) {
        guard let tripsvc = storyboard?.instantiateViewController(identifier: "tripsvc") as? TripsVC else {return}
        present(tripsvc, animated: true, completion: nil)
    }
    
    
    @IBAction func galleryBtnPresssed(_ sender: Any) {
        guard let galleryvc = storyboard?.instantiateViewController(identifier: "galleryvc") as? GalleryVC else {return}
        present(galleryvc, animated: true, completion: nil)
    }
    
    
    
    @IBAction func fbBtnPressed(_ sender: Any) {
        if let url = URL(string: "https://www.facebook.com/MinTravel4egypt/") {
                          if #available(iOS 10, *){
                              UIApplication.shared.open(url)
                          }else{
                              UIApplication.shared.openURL(url)
                          }

                      }
    }
    
    
    
    @IBAction func twitterBtnPressed(_ sender: Any) {
        if let url = URL(string: "https://twitter.com/mintravel") {
            if #available(iOS 10, *){
                UIApplication.shared.open(url)
            }else{
                UIApplication.shared.openURL(url)
            }

        }
    }
    
    
    
    @IBAction func readMoreBtnPressed(_ sender: Any) {
        
        guard let tripVC = storyboard?.instantiateViewController(identifier: "tripinfovc") as? TripInfoVC else {return}
            tripVC.userid = self.userid
            tripVC.token = self.token
        present(tripVC, animated: true, completion: nil)
    }

     func AlertMsg(msg: String){
             
             let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
     //        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
             self.present(alert, animated: true)
         }
     let monitor = NWPathMonitor()
     func connectionStatus(){
        // internetConnectionLbl.isHidden = true
         monitor.pathUpdateHandler = { path in
             sleep(1)
             if path.status == .satisfied {
                 print("Connected")
                 DispatchQueue.main.sync {
                    // self.internetConnectionLbl.text = "Connected"
                   //  self.internetConnectionLbl.backgroundColor = .green
                     DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 ){
                     //    self.internetConnectionLbl.isHidden = true
                     }
                 }
             }
             else if path.status == .requiresConnection {
                 print("Connecting")
//                 self.internetConnectionLbl.text = "connecting"
//                    self.internetConnectionLbl.backgroundColor = .yellow
//                    self.internetConnectionLbl.isHidden = false
                self.AlertMsg(msg: "Connecting")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0 ){
                      //  self.internetConnectionLbl.isHidden = true
                    }
             }
             else if path.status == .unsatisfied {
                 print("Disconnected")
                 DispatchQueue.main.sync {
                    // self.internetConnectionLbl.text = "Disconnected"
                     self.AlertMsg(msg: "no internet connection")
                   //  self.internetConnectionLbl.backgroundColor = .red
                    // self.internetConnectionLbl.isHidden = false
                 }
             }
         }
         let queue = DispatchQueue(label:"queue")
         monitor.start(queue: queue)
     }
     

}

extension MainTravelHomeVC : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           imgArray.count
       }
       
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagecell", for: indexPath) as? ImageSliderCell else {return ImageSliderCell()}
           cell.image = imgArray[indexPath.item]
           return cell
       }
       
       func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }
      
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
       }
       
       func scrollViewDidScroll(_ scrollView: UIScrollView) {
           currentIndex = Int(scrollView.contentOffset.x / collectionView.frame.size.width)
           pageControl.currentPage = currentIndex
       }

}













/*
 
 @IBOutlet weak var collectionView: UICollectionView!
     
     @IBOutlet weak var pageControl: UIPageControl!
     
     @IBOutlet weak var tripNameLbl: UILabel!
     
     @IBOutlet weak var tripDescLbl: UILabel!
     
     
     var trips = [TripModel]()
     
        var userid = (Int)()
        var token = (String)()
        
     
     var currentIndex = 0
        var time: Timer?
        var imgArray = [
            UIImage(named: "slide1"),
            UIImage(named: "slide2"),
            UIImage(named: "slide3")
        ]

     
     override func viewDidLoad() {
         super.viewDidLoad()

         collectionView.delegate = self
         collectionView.dataSource = self
         pageControl.numberOfPages = imgArray.count
         
         startTime()
         setupViewData()
        
         
     }
     
     
     
     func setupViewData(){
       
         AuthServices.instance.getTrips { (error:
             Error?, trips: [TripModel]?) in
              
             if let trips = trips {
                 self.trips = trips
                 self.tripNameLbl.text = trips[0].name
                 self.tripDescLbl.text = trips[0].desc
                 
             }
         }
         
     }
     
     func startTime(){
         time = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timeAction), userInfo: nil, repeats: true)
        }
        
        @objc func timeAction(){
            
            let mainPosition = (currentIndex < imgArray.count - 1) ? currentIndex + 1 : 0
            collectionView.scrollToItem(at:IndexPath(item: mainPosition, section: 0), at: .centeredHorizontally, animated: true)
        }
     
    
     
  
     @IBAction func openFbBtnPressed(_ sender: Any) {
         
            if let url = URL(string: "https://www.facebook.com/MinTravel4egypt/") {
                   if #available(iOS 10, *){
                       UIApplication.shared.open(url)
                   }else{
                       UIApplication.shared.openURL(url)
                   }

               }
     }
     
     
     @IBAction func openTWBtnPressed(_ sender: Any) {
             if let url = URL(string: "https://twitter.com/mintravel") {
                             if #available(iOS 10, *){
                                 UIApplication.shared.open(url)
                             }else{
                                 UIApplication.shared.openURL(url)
                             }

                         }
     }
     
     
     
     @IBAction func readMoreBtnPressed(_ sender: Any) {
         
           guard let tripVC = storyboard?.instantiateViewController(identifier: "TripVC") as? TripVC else {return}
               present(tripVC, animated: true, completion: nil)

     }
     
     
     @IBAction func loginBtnPressed(_ sender: Any) {
     }
     
     
     
     
     
     @IBAction func registerBtnPressed(_ sender: Any) {
     }
     
 }


 extension MainTravelVC : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource {
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            imgArray.count
        }
        
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagecell", for: indexPath) as? ImageSliderCell else {return ImageSliderCell()}
            cell.image = imgArray[indexPath.item]
            return cell
        }
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
       
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            currentIndex = Int(scrollView.contentOffset.x / collectionView.frame.size.width)
            pageControl.currentPage = currentIndex
        }
 
 
 */
