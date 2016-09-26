//
//  DAL.swift
//  happer
//
//  Created by Charles Fournier on 21/09/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import RealmSwift

class DAL {
    static let sharedInstance = DAL()
    
    let realm: Realm
    
    private init() {
        realm = try! Realm()
    }
}
