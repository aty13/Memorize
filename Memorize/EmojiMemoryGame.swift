//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Artur Uvarov on 7/4/24.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    static private let emojis: [String] = ["👽", "🪡",  "🐪", "🦧", "🐞", "🦈", "🎲", "📦", "🪭", "📣", "📸"]
    
    static private func createGame() -> MemorizeGame<String> {
        return MemorizeGame(numberOfPairs: 10) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "🆘"
            }
        }
    }
    
    @Published private var model = createGame()
    
    var cards: [MemorizeGame<String>.Card] {
        model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(card: MemorizeGame<String>.Card) {
        model.chooseCard(card)
    }
}
