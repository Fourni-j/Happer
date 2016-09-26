//
//  DAL+User.swift
//  happer
//
//  Created by Charles Fournier on 21/09/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import RealmSwift

extension DAL {
    
    func readUser(byCircle circle: Circle) -> Results<User> {
        let users = self.realm.objects(User.self).filter("circleRawValue = \(circle.rawValue)")
        return users
    }
    
    func readUser(byId id: Int) -> Results<User> {
        let users = self.realm.objects(User.self).filter("id = \(id)")
        return users
    }
    
    func readUser(byEmail email: String) -> Results<User> {
        let users = self.realm.objects(User.self).filter("email = \(email)")
        return users
    }
    
    func readUser(byExp exp: Float) -> Results<User> {
        let users = self.realm.objects(User.self).filter("exp = \(exp)")
        return users
    }

    func readUser(byCredit credit: Int) -> Results<User> {
        let users = self.realm.objects(User.self).filter("credit = \(credit)")
        return users
    }
}
