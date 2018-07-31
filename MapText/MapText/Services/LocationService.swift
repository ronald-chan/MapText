//
//  LocationService.swift
//  MapText
//
//  Created by Ronald Chan on 7/31/18.
//  Copyright © 2018 Ronald Chan. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth.FIRUser
struct LocationService {
    static func editLocation(loc:NotificationLocation) {
        let userRef=Database.database().reference().child("users").child(User.current.uid).child("locations").child(loc.name!)
        let locDict=["latitude":loc.latitude,
                     "longitude":loc.longitude,
                     "phone1":loc.phone1,
                     "phone2":loc.phone2,
                     "phone3":loc.phone3,
                     "phone4":loc.phone4,] as [String : Any]
        userRef.updateChildValues(locDict)
    }
}
