//
//  ContentView.swift
//  Memorize
//
//  Created by Artur Uvarov on 6/30/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView()
        }
        .padding()
        .foregroundStyle(.orange)
    }
}

struct CardView: View {
    var isFaceUp: Bool = false
    
    var body: some View {
        if isFaceUp {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.white)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 3)
                Text("👽")
                    .font(.largeTitle)
            }
        } else {
            RoundedRectangle(cornerRadius: 12)
        }
    }
}

#Preview {
    ContentView()
}
