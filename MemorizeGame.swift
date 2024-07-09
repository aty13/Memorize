//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Artur Uvarov on 7/4/24.
//

import Foundation

struct MemorizeGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    init(numberOfPairs: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        for cardIndex in 0..<max(2, numberOfPairs) {
            let cardContent = cardContentFactory(cardIndex)
            
            cards.append(Card(content: cardContent, id: "\(cardIndex)a"))
            cards.append(Card(content: cardContent, id: "\(cardIndex)b"))
        }
    }
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ index in cards[index].isFaceUp }).only }        
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    // MARK: - Intents
    
    mutating func chooseCard(_ card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[index].isFaceUp && !cards[index].isMatched {
                
                if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
                    if cards[index].content == cards[potentialMatchIndex].content {
                        cards[index].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfOneAndOnlyFaceUpCard = index
                }
                
                cards[index].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        
        let id: String
        var debugDescription: String {
            "\(id):\(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
