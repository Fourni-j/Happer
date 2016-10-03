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
    static func insert(data: [Selfie]) {
        for selfie in data {
            DAL.sharedInstance.add(selfie)
        }
    }

    static func parse(data: AnyObject?) -> Future<[Selfie]> {
        return Future<[Selfie]> {
            guard let json = data as? [AnyObject]
                else { return []}
            var selfies :[Selfie] = []
            for dictionary in json {
                guard
                    let ID = dictionary["id"] as? Int,
                    let category = dictionary["category"] as? String,
                    let state = dictionary["state"] as? String,
                    let _ = dictionary["owner_id"] as? Int,
                    let nbLike = dictionary["nb_like"] as? Int,
                    let rating = dictionary["rating"] as? Int,
                    let urlImage = dictionary["url_image"] as? String
                    else { break }
                let selfie = Selfie()
                selfie.id = ID
                selfie.category = Selfie.Category.init(value: category)
                selfie.state = Selfie.State.init(value: state)
                //selfie.owner = ownerID
                selfie.nbLike = nbLike
                selfie.rating = rating
                selfie.imageURLString = urlImage
                selfies.append(selfie)
            }
            return selfies
        }
    }
}
