//
//  Session.swift
//  happer
//
//  Created by Charles Fournier on 03/10/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation

class Session {
    
    static let sharedInstance = Session()

    var user: User?
    
    private init() {
        user = nil
    }
    
}
