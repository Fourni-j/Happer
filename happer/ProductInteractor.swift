//
//  ProductInteractor.swift
//  happer
//
//  Created by Charles Fournier on 03/10/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation

class ProductInteractor {
    
    func getProducts() {
        Api.getProduct()
            .then { data in ProductWorker.parse(data!) }
            .then { products in ProductWorker.insert(products)}
            .then { ProductPresenter.post(.GetProductSuccess) }
            .fail { error in ProductPresenter.postOnMainThread(.GetProductFailure, object: error) }
    }
    
    func bid(on product: Product) {
        ProductPresenter.post(.BidSuccess)
    }
    
}
