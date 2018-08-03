//
//  EditPhoneNumbersViewController.swift
//  MapText
//
//  Created by Ronald Chan on 8/1/18.
//  Copyright © 2018 Ronald Chan. All rights reserved.
//

import Foundation
import UIKit
class EditPhoneNumbersViewController:UIViewController {
    
    @IBOutlet weak var phone1TextField: UITextField!
    @IBOutlet weak var phone2TextField: UITextField!
    @IBOutlet weak var phone3TextField: UITextField!
    @IBOutlet weak var phone4TextField: UITextField!
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        save()
        performSegue(withIdentifier: "goHome", sender: self)
    }
    
    var loc:NotificationLocation?
    var orig:NotificationLocation?
    override func viewWillAppear(_ animated: Bool) {
        if let loc=loc {
            var textFields=[phone1TextField,phone2TextField,phone3TextField,phone4TextField]
            var numbers=[loc.phone1,loc.phone2,loc.phone3,loc.phone4]
            for i in 0..<textFields.count {
                if let phoneNum=numbers[i] {
                    if phoneNum != -1 {
                        textFields[i]?.text=String("\(phoneNum)")
                    }
                    else {
                        textFields[i]?.text=""
                    }
                }
                else {
                    textFields[i]?.text=""
                }
            }
        }
    }
    func save() {
        
        if let loc=loc {
            loc.phone1=Int(phone1TextField.text!) ?? -1
            loc.phone2=Int(phone2TextField.text!) ?? -1
            loc.phone3=Int(phone3TextField.text!) ?? -1
            loc.phone4=Int(phone4TextField.text!) ?? -1
            
            if let orig=orig {
                LocationService.removeLocation(key: orig.key!)
            }
            LocationService.newLocation(loc: loc)
            
        }
    }

}
