//
//  ModifyLocationViewController.swift
//  MapText
//
//  Created by Ronald Chan on 7/23/18.
//  Copyright © 2018 Ronald Chan. All rights reserved.
//

import Foundation
import UIKit
class ModifyLocationViewController:UIViewController {
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var phone1TextField: UITextField!
    @IBOutlet weak var phone2TextField: UITextField!
    @IBOutlet weak var phone3TextField: UITextField!
    @IBOutlet weak var phone4TextField: UITextField!
    
    var loc:NotificationLocation?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier=segue.identifier
            else {return}
        switch identifier
        {
        case "save" where loc == nil:
            let loc=CoreDataHelper.newLocation()
            loc.name=locationTextField.text ?? ""
            loc.latitude=Double(latitudeTextField.text!) ?? 0.0
            loc.longitude=Double(longitudeTextField.text!) ?? 0.0
            loc.phone1=Int64(phone1TextField.text!) ?? -1
            loc.phone2=Int64(phone2TextField.text!) ?? -1
            loc.phone3=Int64(phone3TextField.text!) ?? -1
            loc.phone4=Int64(phone4TextField.text!) ?? -1
            CoreDataHelper.saveLocation()
        case "save" where loc != nil:
            loc?.name=locationTextField.text ?? ""
            loc?.latitude=Double(latitudeTextField.text!) ?? 0.0
            loc?.longitude=Double(longitudeTextField.text!) ?? 0.0
            loc?.phone1=Int64(phone1TextField.text!) ?? -1
            loc?.phone2=Int64(phone2TextField.text!) ?? -1
            loc?.phone3=Int64(phone3TextField.text!) ?? -1
            loc?.phone4=Int64(phone4TextField.text!) ?? -1
            CoreDataHelper.saveLocation()
        case "cancel":
            print("Cancel")
        default:
            print("unexpected segue identifier")
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let loc=loc {
            locationTextField.text=loc.name
            longitudeTextField.text=String(loc.longitude)
            latitudeTextField.text=String(loc.latitude)
            phone1TextField.text=String(loc.phone1)
            phone2TextField.text=String(loc.phone2)
            phone3TextField.text=String(loc.phone3)
            phone4TextField.text=String(loc.phone4)
        }
        else{
            locationTextField.text=""
            longitudeTextField.text=""
            latitudeTextField.text=""
            phone1TextField.text=""
            phone2TextField.text=""
            phone3TextField.text=""
            phone4TextField.text=""
        }
    }
    
}
