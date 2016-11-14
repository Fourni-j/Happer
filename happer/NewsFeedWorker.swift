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
        let results = DAL.sharedInstance.readAllSelfies()
        for oldSelfie in results {
            DAL.sharedInstance.delete(oldSelfie)
        }
        for selfie in selfies {
            NewsFeedWorker.insert(selfie)
        }
    }
    
    static func insert(selfie: Selfie) {
            DAL.sharedInstance.add(selfie)
    }

    static func parse(data: AnyObject) -> Future<[Selfie]> {
        return Future<[Selfie]> {
            var selfies = [Selfie]()

            
            let type = data as! [String: AnyObject]
            let array = type["selfies"] as! [[String: AnyObject]]
            for selfieJSON in array {
                guard let category = selfieJSON["category"] as? String,
                let id = selfieJSON["id"] as? Int,
                let nbLike = selfieJSON["nb_like"] as? Int,
                let urlImage = selfieJSON["picture_url"] as? String,
                let state = selfieJSON["state"] as? String
                    else {
                        fatalError("Something goes wrong --> SelfieWorker")
                }
                
                let selfie = Selfie()
                selfie.id = id
                selfie.category = Selfie.Category.init(value: category)
                selfie.nbLike = nbLike
                selfie.imageURLString = urlImage
                selfie.state = Selfie.State.init(value: state)
                selfies.append(selfie)
            }
            return selfies
        }
        
    }
    
}
