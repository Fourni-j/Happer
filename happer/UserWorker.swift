//
//  UserWorker.swift
//  happer
//
//  Created by Charles Fournier on 28/09/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import Future

class UserWorker {
    
    static func insert(data: AnyObject) -> Future<[User]> {
        let users = dictionaryFromArray(data as! [[String: AnyObject]])
        let future = Future<[User]>()
        future.resolve(users)
        return future
    }
    
    private static func dictionaryFromArray(array: [[String: AnyObject]]) -> [User] {
        
        var users = [User]()
        
        for json in array {
            if let user = userFromDictionary(json) {
                users.append(user)
            }
        }
        return users
    }
    
    private static func userFromDictionary(json: [String: AnyObject]) -> User? {
        
        guard let id = json["id"] as? Int,
            let email = json["email"] as? String,
            let exp = json["experience"] as? Double,
            let credit = json["credit"] as? Int,
            let circle = json["circle"] as? String,
            let selfies = json["selfies"] as? [String: AnyObject]
            else {
                print("Something goes wrong ==> User")
                return nil
        }
        
        //        print("----------USER----------")
        //        print("ID : ", id)
        //        print("email : ", email)
        //        print("exp : ", exp)
        //        print("credit : ", credit)
        //        print("circle : ", circle)
        //        print("------------------------")
        
        let user = User()
        user.id = id
        user.email = email
        user.exp = exp
        user.credit = credit
        user.circle = Circle.init(value: circle)
        
        for (_, value) in selfies {
            
            guard let idSelfie = value["id"] as? Int,
                let nbLike = value["nb_like"] as? Int,
                let rating = value["rating"] as? Int,
                let imgURL = value["url_image"] as? String,
                let categorySelfie = value["category"] as? String
                else {
                    print("Something goes wrong ==> Selfie")
                    return nil
            }
            
            //            print("---------SELFIE---------")
            //            print("idSelfie : ", idSelfie)
            //            print("nbLike : ", nbLike)
            //            print("rating : ", rating)
            //            print("imgURL : ", imgURL)
            //            print("category : ", categorySelfie)
            //            print("------------------------")
            
            let selfie = Selfie()
            selfie.id = idSelfie
            selfie.nbLike = nbLike
            selfie.rating = rating
            selfie.imageURLString = imgURL
            selfie.owner = user
            selfie.category = Selfie.Category.init(value: categorySelfie)
            user.selfies.append(selfie)
        }
        //        print(user)
        return user
    }
    
    
}
