//
//  ProductWorker.swift
//  happer
//
//  Created by Charles Fournier on 03/10/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import Future

class ProductWorker {
    
    static func insert(products: [Product]) {
        for product in products {
            ProductWorker.insert(product)
        }
    }
    
    static func insert(product: Product) {
        DAL.sharedInstance.add(product)
    }
    
    static func parse(data: AnyObject) -> Future<[Product]> {
        return Future<[Product]> {
            var products = [Product]()
            
            print(data)
            
            let array = data as! [[String: AnyObject]]
            
            for productJSON in array {
                
                guard let id = productJSON["id"] as? Int,
                    let brand = productJSON["brand"] as? String,
                    let circle = productJSON["circle"] as? String,
                    let completedTime = productJSON["completed_time"] as? Int,
                    let description = productJSON["description"] as? String,
                    let price = productJSON["price"] as? Double,
                    let state = productJSON["state"] as? String,
                    let title = productJSON["title"] as? String,
                    let totalTime = productJSON["total_time"] as? Int,
                    let urlImage = productJSON["url_image"] as? String
                    else {
                        fatalError("Something goes wrong")
                }

                let product = Product()
                product.id = id
                product.brand = brand
                product.circle = Circle.init(value: circle)
                product.completedTime = completedTime
                product.desc = description
                product.price = price
                product.state = Product.State.init(value: state)
                product.title = title
                product.totalTime = totalTime
                product.imageURLString = urlImage

                products.append(product)
            }
            return products
        }
    }
    
    
}
