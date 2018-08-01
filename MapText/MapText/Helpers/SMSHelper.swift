//
//  SMSHelper.swift
//  MapText
//
//  Created by Ronald Chan on 7/26/18.
//  Copyright © 2018 Ronald Chan. All rights reserved.
//

import Foundation
import Alamofire
class SMSHelper {
    static func sendMessage(loc:NotificationLocation) {
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let phoneNums=[loc.phone1,loc.phone2,loc.phone3,loc.phone4]
        for num in phoneNums {
            if let num=num {
                let parameters: Parameters = [
                    "To": num,
                    "Body": "\(User.current.username) arrived within 100 meters of \(loc.name). "
                ]
                
                Alamofire.request("https://snow-labradoodle-8297.twil.io/sms", method: .post, parameters: parameters, headers: headers).response { response in
                    print(response)
                }
            }
        }
    }
    
}
