//
//  categoryClass.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation

class categoryClass {
    
    //MARK : - attributs
    
    internal let id: Int
    internal let name: String
    internal let categoryName: String
    
    
    //MARK : - initialiseur
    
    init(id: Int, name: String, categoryName: String) {
        self.id = id
        self.name = name
        self.categoryName = categoryName
    }
    
    //MARK : - getters
    
    func getID() -> Int {
        return id
    }
    func getName() -> String {
        return name
    }
    func getCategoryName() -> String {
        return categoryName
    }
}