//
//  Card.swift
//  TurnUp
//
//  Created by Vladimir Benko on 19.12.22.
//

import Foundation

struct Card {
    
    var isMatched = false
    var isFaceUp = false
    var identifier: Int
    
    // предоставляет доступ к функционалу данной структуры до ее инициализации, т.е. доступ к свойствам и методам самого типа Сard. Обращение к свойствам и методам через Сard.identifierNumber
    static var identifierNumber = 0
    
    static func identifierGenerator() -> Int {
        identifierNumber += 1
        return identifierNumber
    }
    
    init() {
        self.identifier = Card.identifierGenerator()
    }
}
