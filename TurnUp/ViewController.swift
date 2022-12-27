//
//  ViewController.swift
//  TurnUp
//
//  Created by Vladimir Benko on 19.12.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var touchesLabel: UILabel!
    @IBOutlet private var buttonCollection: [UIButton]!
    
    private(set) var touches = 0 {
        didSet {
            touchesLabel.text = "Touches: \(touches)"
        }
    }
    
    private lazy var game = TurnUpGame(numberOfPairsOfCards: numberOfPairsOfCards)
    private var emojiCollection = ["💡", "🔥", "🌝", "❤️", "🐢", "💡", "🔥", "🌝", "❤️", "🐢", "🏆", "🚦", "⭐️", "🏆", "🚦", "⭐️"]
    private var emojiDictionary = [Int: String]()

    var numberOfPairsOfCards: Int {
        return (buttonCollection.count + 1) / 2
    }
    
    @IBAction private func buttonAction(_ sender: UIButton) {
        touches += 1
        guard let buttonIndex = buttonCollection.firstIndex(of: sender) else { return }
        game.chooseCard(at: buttonIndex)
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
            }
        }
    }
    
    private func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil {
            emojiDictionary[card.identifier] = emojiCollection.remove(at: emojiCollection.count.arc4randomExtension)
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    
}

extension Int {
    var arc4randomExtension: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
