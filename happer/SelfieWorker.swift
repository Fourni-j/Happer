//
//  SelfieWorker.swift
//  happer
//
//  Created by paul on 27/09/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import Future
import RealmSwift

class SelfieWorker {
    func insert(data: AnyObject) -> Future<[Selfie]> {
        DAL.sharedInstance.add(data as! Object)
        return data as! Future<[Selfie]>
    }
}
