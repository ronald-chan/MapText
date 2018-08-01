//
//  EditLocationDetailsViewController.swift
//  MapText
//
//  Created by Ronald Chan on 8/1/18.
//  Copyright © 2018 Ronald Chan. All rights reserved.
//

import Foundation
import UIKit
class EditLocationDetailsViewController:UIViewController {
    
    @IBOutlet weak var locationTextField: UITextField!
    
    var loc:NotificationLocation?
    var orig:NotificationLocation?
    override func viewWillAppear(_ animated: Bool) {
        if let loc=loc {
            locationTextField.text=loc.name
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="toLocation" {
            if let loc=loc {
                loc.name=locationTextField.text ?? ""
            }
            let destination=segue.destination as! EditLocationViewController
            destination.loc=loc
            destination.orig=orig
        }
    }
    @IBAction func unwindWithSegue(_ segue:UIStoryboardSegue) {
        //locs=CoreDataHelper.retrieveLocations()
    }
}
