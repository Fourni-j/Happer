//
//  AuthentWorker.swift
//  happer
//
//  Created by Charles Fournier on 20/12/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import Future

class AuthentWorker {
    
    static func parse(data: AnyObject) {
        
        guard let json = data as? [String:AnyObject]
            else { return }
        
        Session.sharedInstance.token = json["jwt"] as! String
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(json["jwt"], forKey: "USER_TOKEN")
        print("Write data")
    }
    
    
}
