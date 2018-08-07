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
    var loc:NotificationLocation?
    @IBAction func locationActiveSwitchFlipped(_ sender: Any) {
        loc?.locationActive=locationActive.isOn
        LocationService.updateValue(locKey: loc!.key!, key: "locationActive", val: loc?.locationActive)
    }
}
