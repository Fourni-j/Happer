//
//  userClass.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation

class userClass {
    
    // MARK : - attributs
    
    private let id: Int
    private var name: String
    private var rank: Int
    private var level: Int
    private var exp: Float
    private var credit: Int
    
    // MARK : - Initialiseur
    
    init (id: Int, name: String, rank: Int, level: Int, exp: Float, credit: Int) {
        self.id = id
        self.name = name
        self.rank = rank
        self.level = level
        self.exp = exp
        self.credit = credit
    }
    
    // MARK : getters
    
    func getId() -> Int {
        return id
    }
    func getName() -> String {
        return name
    }
    func getRank() -> Int {
        return rank
    }
    func getLevel() -> Int {
        return level
    }
    func getExp() -> Float {
        return exp
    }
    func getCredit() -> Int {
        return credit
    }
    
    // MARK : - update data
    
    private func addExp(amount: Float) {
        exp += amount
    }

    private func addCredit(amount: Int) {
        credit += amount
    }

    private func levelUp() {
        level += 1
    }

    private func rankUp() {
        rank += 1
        exp = 0
    }

    private func subCredit(amount: Int) {
        credit -= amount
        if (credit < 0) {
            credit = 0
        }
    }
}