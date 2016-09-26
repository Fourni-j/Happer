//
//  DAL+Product.swift
//  happer
//
//  Created by Charles Fournier on 21/09/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import RealmSwift

extension DAL {
    
    func readProduct(byId id: Int) -> Results<Product> {
        let products = self.realm.objects(Product.self).filter("id = \(id)")
        return products
    }
    
    func readProduct(byCircle circle: Circle) -> Results<Product> {
        let products = self.realm.objects(Product.self).filter("circleRawValye = \(circle.rawValue)")
        return products
    }
    
    func readProduct(byPrice price: Float) -> Results<Product> {
        let products = self.realm.objects(Product.self).filter("price = \(price)")
        return products
    }
    
    func readProduct(byState state: Product.State) -> Results<Product> {
        let products = self.realm.objects(Product.self).filter("stateRawValue = \(state.rawValue)")
        return products
    }
    
    func readProduct(byTitle title: String) -> Results<Product> {
        let products = self.realm.objects(Product.self).filter("title = \(title)")
        return products
    }
    
    func readProduct(byBrand brand: String) -> Results<Product> {
        let products = self.realm.objects(Product.self).filter("brand = \(brand)")
        return products
    }
    
    func readProduct(byTotalTime totalTime: Int) -> Results<Product> {
        let products = self.realm.objects(Product.self).filter("totalTime = \(totalTime)")
        return products
    }

    func readProduct(byCompletedTime completedTime: Int) -> Results<Product> {
        let products = self.realm.objects(Product.self).filter("completedTime = \(completedTime)")
        return products
    }
    
    func addProduct(product: Product) {
        try! realm.write {
            realm.add(product)
        }
    }

    func deleteProduct(product: Product) {
        try! realm.write {
            realm.delete(product)
        }
    }

    
}
