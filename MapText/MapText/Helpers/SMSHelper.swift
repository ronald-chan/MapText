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
        
        let parameters: Parameters = [
            "To": "+14083682003",
            "Body": "test"
        ]
        
        Alamofire.request("https://snow-labradoodle-8297.twil.io/sms", method: .post, parameters: parameters, headers: headers).response { response in
            print(response)
            
        }
    }
    
}
