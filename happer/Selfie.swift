//
//  Selfie.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift




class RealmString: Object {
    dynamic var stringValue = ""
}

class Selfie : Object {
   
    enum State : Int {
        case Created
        case Promoted
        case Signaled
        case Invalidated
        case Unknown
        
        init(value: Int) {
            if let state = State(rawValue: value) {
                self = state
            }
            else { self = .Unknown }
        }
        
    }
    
    enum Category: String {
        case OOTD
        case OOTN
        case Bags
        case Accessories
        case Shoes
        case Relaxed
        case Unknown
        
        var value : String {
            switch self {
            case .OOTD: return "OOTD"
            case .OOTN: return "OOTN"
            case .Bags: return "Sacs"
            case .Accessories: return "Accessoires"
            case .Shoes: return "Chaussures"
            case .Relaxed: return "Décontracté"
            case .Unknown: return "Unknown"
            }
        }
        
        init(value: String) {
            if let category = Category(rawValue: value) {
                self = category
            }
            else { self = .Unknown }
        }
    }

    
    dynamic var id = 0
    dynamic var owner: User?
    dynamic var nbLike = 0
    dynamic var rating = 0
    dynamic var imageURLString = ""
    
    
    dynamic var stateRawValue = State.Created.rawValue
    var state: State {
        get {
            return State(rawValue: stateRawValue)!
        }
        set {
            stateRawValue = newValue.rawValue
        }
    }
 
    dynamic var categoryRawValue = Category.OOTD.rawValue
    var category: Category {
        get {
            return Category(rawValue: categoryRawValue)!
        }
        set {
            categoryRawValue = newValue.rawValue
        }
    }
    
    var imageURL : NSURL {
        return NSURL(string: "http://" + self.imageURLString)!
    }
    
    var comments: [String] {
        get {
            return _backingComments.map { $0.stringValue }
        }
        set {
            _backingComments.removeAll()
            _backingComments.appendContentsOf(newValue.map { RealmString(value: [$0]) })
        }
    }
    let _backingComments = List<RealmString>()
    
    override class func ignoredProperties() -> [String] {
        return ["comments"]
    }
}