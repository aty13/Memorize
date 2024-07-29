//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Artur Uvarov on 7/4/24.
//

import Foundation
import SwiftUI

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
    
    var color: Color {
        .orange
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(card: MemorizeGame<String>.Card) {
        model.choose(card)
    }
}
