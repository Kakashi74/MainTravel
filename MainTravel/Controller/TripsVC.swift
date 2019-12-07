//
//  TripsVC.swift
//  MainTravel
//
//  Created by Ahmed on 12/5/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import UIKit

class TripsVC: UIViewController {

    
    var trips = [TripModel]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
       // setupViewData()
    }
    

    @IBAction func BackBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func goToDetails(indexPath: IndexPath){
        
        
        guard let tripDetail = storyboard?.instantiateViewController(identifier: "tripinfovc")  as? TripInfoVC else {return}
        
        present(tripDetail, animated: true, completion: nil)
    }
    
    func setupViewData(){
      
        
        AuthServices.instance.getTrips { (error:
            Error?, trips: [TripModel]?) in
             
            if let trips = trips {
                self.trips = trips
//                self.tripNameLbl.text = trips[0].name
//                self.tripDescLbl.text = trips[0].desc
                
            }
        }
        
    }
}


extension TripsVC : UITableViewDelegate , UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tripcell", for: indexPath) as? TripCell
            else {return TripCell()}
        AuthServices.instance.getTrips { ( error: Error?, trips:[TripModel]?) in
            if let trips = trips {
                           self.trips = trips
            let name = self.trips[0].name
            let fromDate = self.trips[0].fromDate
            let toDate = self.trips[0].toDate
             cell.configureCell(name: name, from: fromDate, to: toDate)
        }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           return true
       }
       func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
           return .none
       }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
           
           let actionDelete = UITableViewRowAction(style: .destructive, title: "Go to details") { (rowAction, indexPath) in
               
            self.goToDetails(indexPath: indexPath)
               tableView.deleteRows(at: [indexPath], with: .automatic)
           }
     
           actionDelete.backgroundColor = #colorLiteral(red: 0.2745098039, green: 0.7019607843, blue: 0.9019607843, alpha: 1)
           
           return [actionDelete]
       }

    
}


extension TripsVC{
    
//    func setProgress(atIndexPath indexPaht : IndexPath){
//     
//        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
//          
//        let chosenGoal = goals[indexPaht.row]
//        
//        if chosenGoal.gaolCompletedValue > chosenGoal.gaolProcess {
//            chosenGoal.gaolProcess = chosenGoal.gaolProcess + 1
//        }
//        else {return}
//        do
//               {
//                  try managedContext.save()
//               }
//               catch{
//                   debugPrint("Error Could Not save\(error.localizedDescription)")
//               }
//        
//    }
//    
//    
//    
//    func remove(atIndexPath indexPath : IndexPath)
//    {
//        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
//        managedContext.delete(goals[indexPath.row])
//        do
//        {
//           try managedContext.save()
//        }
//        catch{
//            debugPrint("Error Could Not save\(error.localizedDescription)")
//        }
//        
//    }
//    
//    
//    
//    func fetchRequest( completion :(_ completion : Bool) -> ()){
//       guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
//        
//        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
//        do
//        {
//            goals = try managedContext.fetch(fetchRequest)
//            completion(true)
//        }
//        catch{
//            debugPrint("Error \(error.localizedDescription)")
//        completion(false)
//        }
//        
//        
//    }
//    
    
}
