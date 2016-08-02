//
//  productClass.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation

class productClass {

    //MARK: - attributs
    
    private let price: Float
    private var winned: Bool
    private var description: String
    private let circle: Int
    
    //MARK: initialiseur
    
    init(price: Float, winned: Bool, description: String, circle: Int, id: Int, name: String, categoryName: String) {
        self.price = price
        self.winned = winned
        self.description = description
        self.circle = circle
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
