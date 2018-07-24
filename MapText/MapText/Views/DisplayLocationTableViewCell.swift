//
//  DisplayLocationTableViewCell.swift
//  MapText
//
//  Created by Ronald Chan on 7/23/18.
//  Copyright © 2018 Ronald Chan. All rights reserved.
//

import Foundation
import UIKit
class DisplayLocationTableViewCell:UITableViewCell {
    
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var locationCoordinates: UILabel!
    @IBOutlet weak var locationActive: UISwitch!
    var index:Int = -1
    
    @IBAction func locationActiveSwitchFlipped(_ sender: Any) {
        var locs=CoreDataHelper.retrieveLocations()
        locs[index].locationActive=locationActive.isOn
        CoreDataHelper.saveLocation()
        print(locs[index].locationActive)
    }
}
