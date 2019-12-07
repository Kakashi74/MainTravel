//
//  TripCell.swift
//  MainTravel
//
//  Created by Ahmed on 12/5/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import UIKit

class TripCell: UITableViewCell {

   
    @IBOutlet weak var tripNameText: UILabel!
    @IBOutlet weak var fromDateTxt: UILabel!
    @IBOutlet weak var toDateText: UILabel!
    
    
    func configureCell(name: String ,from: String ,to: String ){
        self.tripNameText.text = name
        self.fromDateTxt.text = from
        self.toDateText.text = to
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
