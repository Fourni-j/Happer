//
//  SelfieClass.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import UIKit

class SelfieClass {
    
    //MARK : - attributs
    
    private let id: Int
    private let categoryName: String
    private let ownerID: Int
    private var nbLike: Int
    private var rate: Int
    private let path: String
    private var image: UIImage
    
    //MARK : - initialiseur
    
    init(ownerID: Int, nbLike: Int, rate: Int, id: Int, categoryName: String, path: String) {
        self.id = id
        self.categoryName = categoryName
        self.ownerID = ownerID
        self.nbLike = nbLike
        self.rate = rate
        self.path = "http://\(path)"
        
        let data = NSData(contentsOfURL: NSURL(string: self.path)!)
        self.image = UIImage(data: data!)!

        
    }
    
    //MARK : - getters
    
    func getId() -> Int {
        return id
    }
    func getCategory() -> String {
        return categoryName
    }
    func getOwnerID() -> Int {
        return ownerID
    }
    func getNbLike() -> Int {
        return nbLike
    }
    func getRate() -> Int {
        return rate
    }
    func getPath() -> String {
        return path
    }
    func getImage() -> UIImage {
        return image
    }
    
    //MARK : - update data
    
    private func addLike() {
        nbLike += 1
    }
}
