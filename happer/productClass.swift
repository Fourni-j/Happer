//
//  productClass.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation

class productClass: categoryClass {

    //MARK: - attributs
    
    private let price: Float
    private var winned: Bool
    private var description: String
    
    //MARK: initialiseur
    
    init(price: Float, winned: Bool, description: String, id: Int, name: String, categoryName: String) {
        self.price = price
        self.winned = winned
        self.description = description
        super.init(id: id, name: name, categoryName: categoryName)
    }
    
    // getters
    
    func getPrice() -> Float {
        return price
    }
    func isWinned() -> Bool {
        return winned
    }
    func getDescription() -> String {
        return description
    }
}
