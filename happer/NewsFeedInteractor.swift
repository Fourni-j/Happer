//
//  NewsFeedInteractor.swift
//  happer
//
//  Created by Charles Fournier on 14/11/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation

class NewsFeedInteractor {
    
    func getSelfies() {
        Api.getSelfie()
            .then { data in NewsFeedWorker.parse(data!) }
            .then { selfies in NewsFeedWorker.insert(selfies) }
            .then { NewsFeedPresenter.post(.GetSelfiesSuccess) }
            .fail { error in NewsFeedPresenter.postOnMainThread(.GetSelfiesFailure, object: error) }
    }
    
}
