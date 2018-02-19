//
//  Card.swift
//  Set
//
//  Created by Raj Makda on 2/13/18.
//  Copyright © 2018 Raj Makda. All rights reserved.
//

import Foundation

struct Card {
    var color: String
    var number: Int
    var shape: String
    var shading: String
    
     static func isSetOfThree(first: Card, second:Card, third:Card) -> Bool {
        let areColorsSet = allSameOrDifferent(first: first.color, second: second.color, third: third.color)
        let areNumbersSet = allSameOrDifferent(first: String(first.number), second: String(second.number), third: String(third.number))
        let areShapesSet = allSameOrDifferent(first: first.shape, second: second.shape, third: third.shape)
        let areShadingsSet = allSameOrDifferent(first: first.shading, second: second.shading, third: third.shading)
        return areColorsSet && areNumbersSet && areShapesSet && areShadingsSet
    }
    
    static func allSameOrDifferent(first: String, second: String, third: String) -> Bool{
        if (first == second) && (first == third) {
            return true
        } else if (first != second) && (second != third) && (first != third) {
            return true
        } else {
            return false
        }
    }
}

extension Card: Equatable {
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.color == rhs.color && lhs.number == rhs.number && lhs.shading == rhs.shading && lhs.shape == rhs.shape
    }
}
