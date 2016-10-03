//
//  ProductPresenter.swift
//  happer
//
//  Created by Charles Fournier on 03/10/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import MagicSwiftBus

@objc protocol ProductEvent {
    optional func getProductSuccess()
    optional func getProductFailure(error: NSError)
    
    optional func bidSuccess()
    optional func bidFailure(error: NSError)
}


class ProductPresenter : Bus {

    enum EventBus: String, EventBusType {
        
        case GetProductSuccess, GetProductFailure, BidSuccess, BidFailure
        
        var notification: Selector {
            switch self {
            case .GetProductSuccess: return #selector(ProductEvent.getProductSuccess)
            case .GetProductFailure: return #selector(ProductEvent.getProductFailure(_:))
            case .BidSuccess: return #selector(ProductEvent.bidSuccess)
            case .BidFailure: return #selector(ProductEvent.bidFailure(_:))
            }
        }
    }
}
