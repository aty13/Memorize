//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Artur Uvarov on 6/30/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            MemorizeGameView(viewModel: game)
        }
    }
}
