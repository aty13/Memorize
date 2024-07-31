//
//  MemorizeGameView.swift
//  Memorize
//
//  Created by Artur Uvarov on 6/30/24.
//

import SwiftUI

struct MemorizeGameView: View {
    
    typealias Card = MemorizeGame<String>.Card
    
    @ObservedObject var viewModel: EmojiMemoryGame
    let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        
        VStack {
            cards
                .foregroundStyle(viewModel.color)
            
            HStack {
                score
                Spacer()
                deck
                    .foregroundStyle(viewModel.color)
                Spacer()
                Button {
                    withAnimation {
                        viewModel.shuffle()
                    }
                    
                } label: {
                    Text("Shuffle")
                }
            }
            
        }
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                CardView(card)
                    .zIndex(scoreChange(causedBy: card) != 0 ? 1000 : 0)
                    .padding(4)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .onTapGesture {
                        choose(card)
                    }
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
    }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    @Namespace private var dealingNamespace
    
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: 50, height: 50 / aspectRatio)
        .onTapGesture {
            deal()
        }
    }
    
    private func deal() {
        var delay: TimeInterval = 0
        
        for card in viewModel.cards {
            withAnimation(.bouncy(duration: 1).delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += 0.15
        }
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    @State var lastScoreChange = (0, changeCausedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        
        return card.id == id ? amount : 0
    }
    
    private func choose(_ card: Card) {
        withAnimation {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card: card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, changeCausedByCardId: card.id)
        }
    }
    
}

#Preview {
    MemorizeGameView(viewModel: EmojiMemoryGame())
}
