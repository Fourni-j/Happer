//
//  User.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import RealmSwift

class User : Object {
    
    dynamic var id = 0
    dynamic var email = ""
    dynamic var exp = 0.0
    dynamic var credit = 0
    
    let selfies = List<Selfie>()
    
    dynamic var circleRawValue = Circle.Unknown.rawValue
    var circle : Circle {
        get {
            return Circle(rawValue: circleRawValue)!
        }
        set {
            circleRawValue = newValue.rawValue
        }
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
