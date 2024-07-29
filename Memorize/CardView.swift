//
//  CardView.swift
//  Memorize
//
//  Created by Artur Uvarov on 7/14/24.
//

import SwiftUI

struct CardView: View {
    
    let card: MemorizeGame<String>.Card
    
    init(_ card: MemorizeGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        TimelineView(.animation) { _ in
            if !card.isMatched || card.isFaceUp {
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    .opacity(Constants.Pie.opacity)
                    .overlay {
                        cardContent
                    }
                    .cardify(isFaceUp: card.isFaceUp)
                    .padding(Constants.Pie.inset)
                    .transition(.scale)
            } else {
                Color.clear
            }
        }
        
    }
    
    private var cardContent: some View {
        Text(card.content)
            .font(.system(size: Constants.FontSize.largest))
            .minimumScaleFactor(Constants.FontSize.scaleFactor)
            .aspectRatio(1, contentMode: .fit)
            .padding(Constants.Pie.inset)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(duration: 1), value: card.isMatched)
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        
        struct Pie {
            static let opacity: CGFloat = 0.5
            static let inset: CGFloat = 5
        }
    }
}

extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: 1).repeatForever(autoreverses: false)
    }
}

#Preview {
    
    typealias Card = MemorizeGame<String>.Card
    
    return VStack {
        HStack {
            CardView(Card(isFaceUp: true, content: "🪡", id: "test1"))
            CardView(Card(content: "👽", id: "test1"))
        }
        
        HStack {
            CardView(Card(content: "X", id: "test1"))
            CardView(Card(isMatched: true, content: "X", id: "test1"))
        }
    }
    .padding()
    .foregroundStyle(.orange)
}
