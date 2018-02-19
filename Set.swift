//
//  Set.swift
//  Set
//
//  Created by Raj Makda on 2/13/18.
//  Copyright © 2018 Raj Makda. All rights reserved.
//

import Foundation

class Set {
    var deck = [Card]()
    var cardsInPlay = [Card]()
    var selectedCards = [Card]()
    var matchedCards = [Card]()
    var isComplete : Bool {
        return matchedCards.count == 81
    }
    var score = 0
    
    let colorSet = ["green","purple","red"]
    let numberSet = [1,2,3]
    let shapeSet = ["●","■","▲"]
    let shadingSet = ["solid","striped","empty"]
    
    init() {
        for i in 0..<3 {
            for j in 0..<3 {
                for k in 0..<3 {
                    for l in 0..<3 {
                        let card = Card(color: colorSet[i], number: numberSet[j], shape: shapeSet[k], shading: shadingSet[l])
                        deck.append(card)
                    }
                }
            }
        }
        deck = shuffleCards(in: deck)
    }
    
    func shuffleCards(in cards: [Card]) -> [Card] {
        var shuffledCards = cards
        var last = shuffledCards.count - 1
        while(last > 0)
        {
            let rand = Int(arc4random_uniform(UInt32(last)))
            shuffledCards.swapAt(last, rand)
            last -= 1
        }
        return shuffledCards
    }
    
    func chooseCard(_ card: Card) {
        var indexOfPreviouslySelectedCard = selectedCards.index(of: card)
        //three cards selected
        if selectedCards.count == 3 {
            indexOfPreviouslySelectedCard = nil
            selectedCards.removeAll()
        } //two cards selected
        else if selectedCards.count == 2 {
            //check if 3 selected cards are matching
            //if match replace them with cards from the deck
            if Card.isSetOfThree(first: selectedCards[0], second: selectedCards[1], third: card) {
                score += 3
                let matchingCards = [selectedCards[0], selectedCards[1], card]
                matchedCards.append(contentsOf: matchingCards)
                for matchedCard in matchingCards {
                    let indexOfMatchedCardInPlay = cardsInPlay.index(of: matchedCard)
                    if let index = indexOfMatchedCardInPlay {
                        if !deck.isEmpty {
                            cardsInPlay[index] = deck.popLast()!
                        } else {
                            cardsInPlay.remove(at: index)
                        }
                    }
                }
                selectedCards.removeAll()
            } else {
                //cards do not match
                if selectedCards[0] != card && selectedCards[1] != card {
                    score -= 4
                }
            }
        }
        if indexOfPreviouslySelectedCard == nil && !matchedCards.contains(card) {
            selectedCards.append(card)
        } else if let index = indexOfPreviouslySelectedCard {
            score -= 1
            selectedCards.remove(at: index)
        }
    }
    
    func drawCards(numberOfCards: Int) {
        if !deck.isEmpty && deck.count >= numberOfCards {
            cardsInPlay.append(contentsOf: deck[0..<numberOfCards])
            deck.removeSubrange(0..<numberOfCards)
        } else {
            print("deck contents: \(deck)")
        }
    }
    
}
