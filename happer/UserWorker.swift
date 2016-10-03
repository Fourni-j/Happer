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
    
    static func insert(users: [User]){
        for user in users {
            UserWorker.insert(user)
        }
    }
    
    static func insert(user: User) {
        DAL.sharedInstance.add(user)
    }
    
    static func parse(data: AnyObject) -> Future<[User]> {
        return Future<[User]> {
            var users = [User]()
            let array = data as! [[String: AnyObject]]
            
            for userJSON in array {
                
                guard let id = userJSON["id"] as? Int,
                    let email = userJSON["email"] as? String,
                    let exp = userJSON["experience"] as? Double,
                    let credit = userJSON["credit"] as? Int,
                    let circle = userJSON["circle"] as? String,
                    let _ = userJSON["selfies"] as? [String: AnyObject]
                    else {
                        fatalError("Something goes wrong")
                }
                
                let user = User()
                user.id = id
                user.email = email
                user.exp = exp
                user.credit = credit
                user.circle = Circle.init(value: circle)
                
                //SelfieWorker.parse(selfies)
                // .then { selfies in }
                
                users.append(user)
            }
            return users
        }
    }
}
