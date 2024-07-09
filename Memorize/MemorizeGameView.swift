//
//  MemorizeGameView.swift
//  Memorize
//
//  Created by Artur Uvarov on 6/30/24.
//

import SwiftUI

struct MemorizeGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        
        VStack {
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button {
                viewModel.shuffle()
            } label: {
                Text("Shuffle")
            }
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card: card)
                    }
            }
        }
        .foregroundStyle(.orange)
    }
}

struct CardView: View {
    
    let card: MemorizeGame<String>.Card
    
    init(_ card: MemorizeGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)

            base
                .fill()
                .opacity(card.isFaceUp ? 0 : 1)
         }
        .opacity(!card.isMatched || card.isFaceUp ? 1 : 0)
    }
}

#Preview {
    MemorizeGameView(viewModel: EmojiMemoryGame())
}
