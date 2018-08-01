//
//  EditLocationViewController.swift
//  MapText
//
//  Created by Ronald Chan on 8/1/18.
//  Copyright © 2018 Ronald Chan. All rights reserved.
//

import Foundation
import UIKit
class EditLocationViewController:UIViewController {
    
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    
    var loc:NotificationLocation?
    var orig:NotificationLocation?
    override func viewWillAppear(_ animated: Bool) {
        if let loc=loc {
            longitudeTextField.text=String("\(loc.longitude)")
            latitudeTextField.text=String("\(loc.latitude)")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let loc=loc {
            loc.latitude=Double(latitudeTextField.text!) ?? 0.0
            loc.longitude=Double(longitudeTextField.text!) ?? 0.0
        }
        if segue.identifier=="toPhoneNumber" {            
            let destination=segue.destination as! EditPhoneNumbersViewController
            destination.loc=loc
            destination.orig=orig
        }
    }
    @IBAction func unwindWithSegue(_ segue:UIStoryboardSegue) {
        //locs=CoreDataHelper.retrieveLocations()
    }
}
