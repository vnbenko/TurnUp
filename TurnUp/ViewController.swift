//
//  ViewController.swift
//  TurnUp
//
//  Created by Vladimir Benko on 19.12.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var touchesLabel: UILabel!
    @IBOutlet var buttonCollection: [UIButton]!
    
    var emojiCollection = ["💡", "🔥", "🌝", "❤️", "🐢", "💡", "🔥", "🌝", "❤️", "🐢", "🏆", "🚦", "⭐️", "🏆", "🚦", "⭐️"]
    
    var touches = 0 {
        didSet {
            touchesLabel.text = "Touches: \(touches)"
        }
    }
    
    lazy var game = TurnUpGame(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (buttonCollection.count + 1) / 2
    }
    
    var emojiDictionary = [Int: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        touches += 1
        guard let buttonIndex = buttonCollection.firstIndex(of: sender) else { return }
        game.chooseCard(at: buttonIndex)
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
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
    
    func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil {
            let randomIndex = Int.random(in: 0...emojiCollection.count)
            emojiDictionary[card.identifier] = emojiCollection.remove(at: randomIndex)
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    
}

