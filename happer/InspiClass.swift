//
//  InspiClass.swift
//  happer
//
//  Created by Josse on 01/07/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class InspiClass {
    
    // MARK: - attributs
    
    private let name: String
    private let keyWord: String
    
    // MARK: - initialiseur
    
    init(name: String, keyWord: String) {
        self.name = name
        self.keyWord = keyWord
    }
    
    // MARK: - getters
    
    func getName() -> String {
        return self.name
    }
    /*func getImage() -> UIImage {
        return self.image
    }*/
    func getKey() -> String {
        return self.keyWord
    }
}
