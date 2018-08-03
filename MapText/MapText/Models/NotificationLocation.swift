//
//  NotificationLocation.swift
//  MapText
//
//  Created by Ronald Chan on 7/31/18.
//  Copyright © 2018 Ronald Chan. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot
class NotificationLocation {
    
    private static var _current: NotificationLocation?
    
    static var current: NotificationLocation {
        guard let currentLoc = _current else {
            fatalError("Error: current notification doesn't exist")
        }
        return currentLoc
    }
    var latitude:Double
    var locationActive:Bool=false
    var recentlyTriggered:Bool=false
    var longitude:Double
    var name:String
    var city:String
    var state:String
    var streetAddress:String
    var notes:String?
    var phone1:Int?
    var phone2:Int?
    var phone3:Int?
    var phone4:Int?
    var key:String?
    init(lat:Double, long:Double, name:String) {
        locationActive=true
        recentlyTriggered=false
        latitude=lat
        longitude=long
        self.name=name
        city=""
        state=""
        streetAddress=""
    }
    init(loc:NotificationLocation) {
        latitude=loc.latitude
        longitude=loc.longitude
        locationActive=loc.locationActive
        recentlyTriggered=loc.recentlyTriggered
        name=loc.name
        notes=loc.notes
        phone1=loc.phone1
        phone2=loc.phone2
        phone3=loc.phone3
        phone4=loc.phone4
        key=loc.key
        city=loc.city
        state=loc.state
        streetAddress=loc.streetAddress
    }
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let lat = dict["latitude"] as? Double,
            let long = dict["longitude"] as? Double,
            let street=dict["streetAddress"] as? String,
            let city=dict["city"] as? String,
            let state=dict["state"] as? String,
            let phone1 = dict["phone1"] as? Int,
            let phone2=dict["phone2"] as? Int,
            let phone3=dict["phone3"] as? Int,
            let phone4=dict["phone4"] as? Int,
            let name=dict["name"] as? String,
            let notes=dict["notes"] as? String,
            let locationActive=dict["locationActive"] as? Bool
            else { return nil }
        
        latitude=lat
        longitude=long
        self.phone1=phone1
        self.phone2=phone2
        self.phone3=phone3
        self.phone4=phone4
        self.name=name
        self.notes=notes
        self.key=snapshot.key
        self.locationActive=locationActive
        self.streetAddress=street
        self.city=city
        self.state=state
    }
}
