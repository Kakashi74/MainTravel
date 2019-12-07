//
//  GalleryVC.swift
//  MainTravel
//
//  Created by Ahmed on 12/3/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import UIKit

class GalleryVC: UIViewController {

   
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        
        setData()
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func setData(){
        AuthServices.instance.getGallery { (error, photos: [Photo]?) in
            if let photos = photos {
            self.photos = photos
                self.collectionView.reloadData()
        }
        
        
        
    }
    }
     
}



extension GalleryVC : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
   

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let screenWidth = UIScreen.main.bounds.width
        var width = (screenWidth - 30) / 2
        width = width > 200 ? 200 : width
        return CGSize(width: 150, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photocell", for: indexPath) as? PhotoCell  else {return PhotoCell()}
      cell.photo = photos[indexPath.item]
        return cell
    }
    
}
