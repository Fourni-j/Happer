//
//  DAL+Selfie.swift
//  happer
//
//  Created by Charles Fournier on 21/09/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import RealmSwift

extension DAL {
    
    func readSelfie(byId id: Int) -> Results<Selfie> {
        let selfies = self.realm.objects(Selfie.self).filter("id = \(id)")
        return selfies
    }

    func readSelfie(byCategory category: Selfie.Category) -> Results<Selfie> {
        let selfies = self.realm.objects(Selfie.self).filter("categoryRawValue = '\(category.rawValue)'")
        return selfies
    }

    func readSelfie(byState state: Selfie.State) -> Results<Selfie> {
        let selfies = self.realm.objects(Selfie.self).filter("stateRawValue = '\(state.rawValue)'")
        return selfies
    }

    func readSelfie(byOwner owner: User) -> Results<Selfie> {
        let selfies = self.realm.objects(Selfie.self).filter("owner = \(owner)")
        return selfies
    }

    func readSelfie(byNbLike nbLike: Int) -> Results<Selfie> {
        let selfies = self.realm.objects(Selfie.self).filter("nbLike = \(nbLike)")
        return selfies
    }

    func readSelfie(byRating rating: Int) -> Results<Selfie> {
        let selfies = self.realm.objects(Selfie.self).filter("rating = \(rating)")
        return selfies
    }
    
    func readAllSelfies() -> Results<Selfie> {
        let selfies = self.realm.objects(Selfie.self)
        return selfies
    }
}
