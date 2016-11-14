//
//  NewsFeedWorker.swift
//  happer
//
//  Created by Charles Fournier on 14/11/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import Future

class NewsFeedWorker {
    
    static func insert(selfies: [Selfie]) {
        for selfie in selfies {
            NewsFeedWorker.insert(selfie)
        }
    }
    
    static func insert(selfie: Selfie) {
            DAL.sharedInstance.add(selfie)
    }

    static func parse(data: AnyObject) -> Future<[Selfie]> {
        return Future<[Selfie]> {
            let selfies = [Selfie]()
            return selfies
        }
        
    }
    
}
