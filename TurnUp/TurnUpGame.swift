//
//  TurnUpGame.swift
//  TurnUp
//
//  Created by Vladimir Benko on 19.12.22.
//

import Foundation

class TurnUpGame {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            // проверка карточек по след. условиям: 1. является ли эта карточка единственной перевернутой, 2. не нажимает ли пользователь на ту же самую карточку)
            if let matchingIndex = indexOfOneAndOnlyFaceUpCard, matchingIndex != index {
                // проверка на совпадение карточек
                if cards[matchingIndex].identifier == cards[index].identifier {
                    cards[matchingIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
    }
}
