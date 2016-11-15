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
            let type = data as! [String: AnyObject]
            let array = type["products"] as! [[String: AnyObject]]
            for productJSON in array {
                guard let id = productJSON["id"] as? Int,
                    let brand = productJSON["brand"] as? String,
                    let description = productJSON["description"] as? String,
                    let price = productJSON["price"] as? String,
                    let title = productJSON["title"] as? String,
                    var urlImage = productJSON["picture_url"] as? String,
                    let state = productJSON["state"] as? String
                    //                    let totalTime = productJSON["total_time"] as? Int,
                    //                    let circle = productJSON["circle"] as? Int,
                    //                    let completedTime = productJSON["completed_time"] as? Int,
                    else {
                        fatalError("Something goes wrong")
                }
                
                let product = Product()
                product.id = id
                product.brand = brand
                product.circle = Circle.init(value: "Silver")
                product.desc = description
                product.price = Double(price)!
                product.state = Product.State.init(value: state)
                product.title = title
                urlImage.removeAtIndex(urlImage.startIndex)
                urlImage.removeAtIndex(urlImage.startIndex)
                product.imageURLString = urlImage
                products.append(product)
                
                //                product.totalTime = totalTime
                //                product.completedTime = completedTime
                
            }
            return products
        }
    }
}
