//
//  CardView.swift
//  laborat5
//
//  Created by student on 14/11/2023.
//

import SwiftUI

struct CardView : View {
    var card: MemoGameModel<String>.Card
    var viewModel: MemoGameViewModel
    
    init(_ card: MemoGameModel<String>.Card, _ viewModel: MemoGameViewModel) {
        self.card  = card
        self.viewModel = viewModel
    }
    
    
    var body: some View {
        CirclePart(endAngle: .degrees(240))
            .opacity(0.4)
            .overlay(
               Text(card.content)
                   .font(.system(size: 200))
                   .minimumScaleFactor(0.01)
                   .aspectRatio(1, contentMode: .fit)
                   .opacity(card.isFaceUp ? 1 : 0)
                   .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                   .animation(.linear(duration: 2), value: card.isMatched)
            )
            .padding(5)
            .transformIntoCard(isFaceUp: card.isFaceUp)
        .onTapGesture {
            withAnimation{
                viewModel.chooseWithAnimation(card: card)
            }
            
        }
        
    }
}

extension Animation {
    static func spin(duration: TimeInterval) -> Animation{
        .linear(duration: duration).repeatForever(autoreverses: false)
    }
}
#Preview {
    CardView(MemoGameModel<String>.Card(isFaceUp: true, content: "X", id: "index1"), MemoGameViewModel())
        .padding(5)
}
