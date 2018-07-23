//
//  Location.swift
//  MapText
//
//  Created by Ronald Chan on 7/23/18.
//  Copyright © 2018 Ronald Chan. All rights reserved.
//

import Foundation
class Location {
    var latitude:Double
    var longitude:Double
    var name:String
    var description:String
    var numbers:[Int]
    init(latitude:Double,longitude:Double,name:String,description:String,numbers:[Int]) {
        self.latitude=latitude
        self.longitude=longitude
        self.name=name
        self.description=description
        self.numbers=numbers
    }
}
