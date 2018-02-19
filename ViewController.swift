//
//  ViewController.swift
//  Set
//
//  Created by Raj Makda on 2/13/18.
//  Copyright © 2018 Raj Makda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var game = Set()
    var gameStarted = false
    @IBOutlet lazy var cardButtons: [UIButton]! = {
        setInitialButtonsView()
    }()
    @IBOutlet weak var dealCardsButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    func setInitialButtonsView() -> [UIButton] {
        for index in game.cardsInPlay.indices {
            cardButtons[index].setTitle("", for: UIControlState.normal)
            cardButtons[index].isEnabled = false;
            cardButtons[index].layer.borderWidth = 3.0
            cardButtons[index].layer.borderColor = UIColor.black.cgColor
            cardButtons[index].layer.cornerRadius = 8.0
        }
        return cardButtons
    }
    
    @IBAction func selectCard(_ sender: UIButton) {
        if !game.isComplete {
            if let indexOfSelectedCard = cardButtons.index(of: sender) {
                game.chooseCard(game.cardsInPlay[indexOfSelectedCard])
            }
            syncUIWithModel()
        }
        print("Cards in play = \(game.cardsInPlay.count) , Cards left in deck = \(game.deck.count), Matching cards = \(game.matchedCards.count)")
    }
    
    @IBAction func drawCards(_ sender: UIButton) {
        if game.cardsInPlay.count < 24 {
            if !gameStarted {
                game.drawCards(numberOfCards: 12)
                dealCardsButton.setTitle("Deal 3 cards", for: UIControlState.normal)
                gameStarted = !gameStarted
            } else {
                    game.drawCards(numberOfCards: 3)
            }
            syncUIWithModel()
        }
    }
    
    func syncUIWithModel() {
        scoreLabel.text = "Score: \(game.score)"
        if game.deck.isEmpty || game.cardsInPlay.count >= 24 {
            dealCardsButton.isEnabled = false
        } else if game.cardsInPlay.count < 24 {
            dealCardsButton.isEnabled = true
        }
        for index in cardButtons.indices {
            if index < game.cardsInPlay.count {
                cardButtons[index].isEnabled = true
                cardToButtonView(for: cardButtons[index], with: game.cardsInPlay[index])
            } else {
                cardButtons[index].isEnabled = false
                cardToButtonView(for: cardButtons[index], with: Card(color: "white", number: 0, shape: "", shading: "empty"))
            }
        }
        if game.isComplete {
            game = Set()
            gameStarted = false
            dealCardsButton.setTitle("Restart Game", for: UIControlState.normal)
            dealCardsButton.isEnabled = true
        }
        selectedCardUI()
    }
    
    func selectedCardUI()   {
        for index in game.cardsInPlay.indices {
            if game.selectedCards.contains(game.cardsInPlay[index]) {
                    cardButtons[index].layer.borderWidth = 3.0
                    cardButtons[index].layer.borderColor = UIColor.blue.cgColor
                    cardButtons[index].layer.cornerRadius = 8.0
            } else {
                cardButtons[index].layer.borderWidth = 3.0
                cardButtons[index].layer.borderColor = UIColor.black.cgColor
                cardButtons[index].layer.cornerRadius = 8.0
            }
        }
        for index in game.cardsInPlay.count..<cardButtons.count {
                cardButtons[index].layer.borderWidth = 3.0
                cardButtons[index].layer.borderColor = UIColor.black.cgColor
                cardButtons[index].layer.cornerRadius = 8.0
        }
    }
    
    func cardToButtonView(for button: UIButton ,with card: Card) {
        var buttonTitle = ""
        let cardShape = card.shape
        let cardNumber = card.number
        let cardColor = card.color
        var swiftColor = UIColor.white
        if cardColor == "red" {
            swiftColor = UIColor.red
        } else if cardColor == "green" {
            swiftColor = UIColor.green
        } else if cardColor == "purple" {
            swiftColor = UIColor.purple
        }
        let cardShading = card.shading
        for _ in 0..<cardNumber {
            buttonTitle = buttonTitle + cardShape
        }
        if cardShading == "empty" {
            let myAttribute = [ NSAttributedStringKey.foregroundColor: swiftColor, NSAttributedStringKey.strokeWidth: 2] as [NSAttributedStringKey : Any]
             let myAttrString = NSAttributedString(string: buttonTitle, attributes: myAttribute)
             button.setAttributedTitle(myAttrString, for: UIControlState.normal)
        } else if cardShading == "striped" {
            let myAttribute = [ NSAttributedStringKey.foregroundColor: swiftColor.withAlphaComponent(0.25)] as [NSAttributedStringKey : Any]
             let myAttrString = NSAttributedString(string: buttonTitle, attributes: myAttribute)
             button.setAttributedTitle(myAttrString, for: UIControlState.normal)
        } else {
            let myAttribute = [ NSAttributedStringKey.foregroundColor: swiftColor.withAlphaComponent(1)] as [NSAttributedStringKey : Any]
            let myAttrString = NSAttributedString(string: buttonTitle, attributes: myAttribute)
             button.setAttributedTitle(myAttrString, for: UIControlState.normal)
        }
    }
}
