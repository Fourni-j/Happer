//
//  NewsFeedPresenter.swift
//  happer
//
//  Created by Charles Fournier on 14/11/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import MagicSwiftBus

@objc protocol NewsFeedEvent {
    
    optional func getSelfiesSuccess()
    optional func getSelfiesFailure(error: NSError)
    
}


class NewsFeedPresenter : Bus {
    
    enum EventBus: String, EventBusType {
        
        case GetSelfiesSuccess, GetSelfiesFailure
        
        var notification: Selector {
            switch self {
            case .GetSelfiesSuccess: return #selector(NewsFeedEvent.getSelfiesSuccess)
            case .GetSelfiesFailure: return #selector(NewsFeedEvent.getSelfiesFailure(_:))
            }
        }
        
    }
    
}
