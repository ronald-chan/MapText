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
    static func newLocation(loc:NotificationLocation) {
        let userRef=Database.database().reference().child("locations").child(User.current.uid).childByAutoId()
        let key=userRef.key
        let locDict=["name":loc.name,
                     "latitude":loc.latitude,
                     "longitude":loc.longitude,
                     "phone1":loc.phone1,
                     "phone2":loc.phone2,
                     "phone3":loc.phone3,
                     "phone4":loc.phone4,
                     "locationActive":loc.locationActive,
                     "key":key] as [String : Any]
        userRef.updateChildValues(locDict)
    }
    static func removeLocation(key:String) {
        let userRef=Database.database().reference().child("locations").child(User.current.uid).child(key)
        userRef.removeValue()
    }
    static func updateValue(locKey:String,key:String,val:Any) {
        let userRef=Database.database().reference().child("locations").child(User.current.uid).child(locKey)
        userRef.updateChildValues([key:val])
        
    }
}