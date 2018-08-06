//
//  EditLocationViewController.swift
//  MapText
//
//  Created by Ronald Chan on 8/1/18.
//  Copyright © 2018 Ronald Chan. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
class EditLocationViewController:UIViewController {
    
    @IBOutlet weak var streetAddressTextField: UITextField!
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    
    var geoCoder=CLGeocoder()
    var loc:NotificationLocation?
    var orig:NotificationLocation?
    override func viewWillAppear(_ animated: Bool) {
        if let loc=loc {
            streetAddressTextField.text=loc.streetAddress
            stateTextField.text=loc.state
            cityTextField.text=loc.city
//            longitudeTextField.text=String("\(loc.longitude)")
//            latitudeTextField.text=String("\(loc.latitude)")
            streetAddressTextField.becomeFirstResponder()
            
            streetAddressTextField.autocapitalizationType=UITextAutocapitalizationType.words
            cityTextField.autocapitalizationType=UITextAutocapitalizationType.words
            stateTextField.autocapitalizationType=UITextAutocapitalizationType.allCharacters
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let loc=loc {
            loc.streetAddress=streetAddressTextField.text ?? ""
            loc.state=stateTextField.text ?? ""
            loc.city=cityTextField.text ?? ""
            geoCoder.geocodeAddressString("\(loc.streetAddress), \(loc.city), \(loc.state)") { (placemarks, error) in
                if error != nil {
                    return
                }
                if let places=placemarks {
                    let location=places[0].location
                    loc.latitude=location?.coordinate.latitude ?? Double(Int.max)
                    loc.longitude=location?.coordinate.longitude ?? Double(Int.max)
                }
            }
//            loc.latitude=Double(latitudeTextField.text!) ?? 0.0
//            loc.longitude=Double(longitudeTextField.text!) ?? 0.0
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
