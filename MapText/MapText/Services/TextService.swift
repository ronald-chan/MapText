//
//  TextService.swift
//  MapText
//
//  Created by Ronald Chan on 8/1/18.
//  Copyright © 2018 Ronald Chan. All rights reserved.
//

import Foundation
import CoreLocation
class TextService {
    static var appActive:Bool=true
    static var locs:[NotificationLocation]=[]
    static func test() {
        if appActive {
            UserService.locs(for: User.current) { (locs) in
                self.locs = locs
            }
        }
        SMSHelper.sendMessage(loc: locs[0])
    }
}
