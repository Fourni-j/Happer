//
//  Product.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import RealmSwift

enum Circle : Int {
    case Silver
    case Gold
    case Rubis
    case Saphire
    case Platine
    case Unknown
    
    var value : String {
        switch self {
        case .Silver: return "Silver"
        case .Gold: return "Gold"
        case .Rubis: return "Rubis"
        case .Saphire: return "Saphire"
        case .Platine: return "Platines"
        case .Unknown: return "Unknown"
        }
    }
    
    
    init(value: Int) {
        if let circle = Circle(rawValue: value) {
            self = circle
        }
        else { self = .Unknown }
    }
}


class Product : Object {

    enum State : Int {
        case Soon
        case Available
        case Won
        case Unknown
    
        init(value: Int) {
            if let state = State(rawValue: value) {
                self = state
            }
            else { self = .Unknown }
        }
    }
    
    dynamic var id = 0
    dynamic var price = 0.0
    dynamic var desc = ""
    dynamic var title = ""
    dynamic var brand = ""
    dynamic var totalTime = 0
    dynamic var completedTime = 0

    dynamic var stateRawValue = State.Unknown.rawValue
    var state : State {
        get {
            return State(rawValue: stateRawValue)!
        }
        set {
            stateRawValue = newValue.rawValue
        }
    }
    
    dynamic var circleRawValue = Circle.Unknown.rawValue
    var circle : Circle {
        get {
            return Circle(rawValue: circleRawValue)!
        }
        set {
            circleRawValue = newValue.rawValue
        }
    }
    
    var remaining_time : Int {
        return totalTime - completedTime
    }
}
