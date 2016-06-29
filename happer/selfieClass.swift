//
//  selfieClass.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation

class selfieClass: categoryClass {
    
    //MARK : - attributs
    
    private let ownerID: Int
    private var nbLike: Int
    private var rate: Int
    private var valide: Bool
    
    //MARK : - initialiseur
    
    init(ownerID: Int, nbLike: Int, rate: Int, valide: Bool, id: Int, name: String, categoryName: String) {
        self.ownerID = ownerID
        self.nbLike = nbLike
        self.rate = rate
        self.valide = valide
        super.init(id: id, name: name, categoryName: categoryName)
    }
    
    //MARK : - getters
    
    func getOwnerID() -> Int {
        return ownerID
    }
    func getNbLike() -> Int {
        return nbLike
    }
    func getRate() -> Int {
        return rate
    }
    func isValide() -> Bool {
        return valide
    }
    
    //MARK : - update data
    
    private func addLike() {
        nbLike += 1
    }
}