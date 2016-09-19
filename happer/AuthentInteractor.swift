//
//  LoginInteractor.swift
//  happer
//
//  Created by Charles Fournier on 19/09/16.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation

class AuthentInteractor {

    func connection(username: String, pass: String) {
        AuthentPresenter.post(.ConnectSuccess)
    }
    
    func subscribe(username: String, pass: String, mail: String) {
        AuthentPresenter.post(.SubscribeSuccess)
    }
}
