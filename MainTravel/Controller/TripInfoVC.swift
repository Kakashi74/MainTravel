//
//  TripInfoVC.swift
//  MainTravel
//
//  Created by Ahmed on 12/5/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import UIKit

class TripInfoVC: UIViewController {

    
    
    @IBOutlet weak var tripNameTxt: UILabel!
    
    
    @IBOutlet weak var priceTxt: UILabel!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var progressLbl: UIPageControl!
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        progressLbl.numberOfPages = imgArray.count
        
        startTime()
        setupViewData()
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func bookTripBtnPressed(_ sender: Any) {
        guard let booktripvc = storyboard?.instantiateViewController(identifier: "booktripvc") as? BookTripVC else {return}
              booktripvc.userid = self.userid
              booktripvc.token = self.token
        present(booktripvc, animated: true, completion: nil)
        
    }
    
    
    
    func setupViewData(){
             
               AuthServices.instance.getTrips { (error:
                   Error?, trips: [TripModel]?) in
                    
                   if let trips = trips {
                       self.trips = trips
                       self.tripNameTxt.text = trips[0].name
                       self.priceTxt.text = "\(trips[0].salary)"
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
        
      

    }



    extension TripInfoVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                 imgArray.count
             }
             
             
             func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                 guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgcell", for: indexPath) as? ImgCell else {return ImageSliderCell()}
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
                 progressLbl.currentPage = currentIndex
             }
        
        
    }
