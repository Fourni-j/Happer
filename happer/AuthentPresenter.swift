//
//  AuthentPresenter.swift
//  happer
//
//  Created by Charles Fournier on 19/09/16.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation

@objc protocol AuthentEvent {
    optional func connectSuccess()
    optional func connectFailure(error: NSError)
    
    optional func subscribeSuccess()
    optional func subscribeFailure(error: NSError)
}

class AuthentPresenter : Bus {
    
    enum EventBus: String, EventBusType {
        
        case ConnectSuccess, ConnectFailure, SubscribeSuccess, SubscribeFailure
        
        var notification: Selector {
            switch self {
            case .ConnectSuccess: return #selector(AuthentEvent.connectSuccess)
            case .ConnectFailure: return #selector(AuthentEvent.connectFailure(_:))
            case .SubscribeSuccess: return #selector(AuthentEvent.subscribeSuccess)
            case .SubscribeFailure: return #selector(AuthentEvent.subscribeFailure(_:))
            }
        }
    }
}
