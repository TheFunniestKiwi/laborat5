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
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(card.isFaceUp ? Color.white : Color(viewModel.color))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(lineWidth: 3)
                        .opacity(card.isFaceUp ? 1 : 0)
                )
                .overlay(
                    Text(card.content)
                        .font(.system(size: 200))
                        .minimumScaleFactor(0.01)
                        .aspectRatio(1, contentMode: .fit)
                        .opacity(card.isFaceUp ? 1 : 0)
                        .rotation3DEffect(
                            .degrees(card.isFaceUp ? 0 : 180),
                            axis: (x: 0.0, y: 1.0, z: 0.0)
                        )
                )
        }
        .onTapGesture {
            viewModel.chooseWithAnimation(card: card)
        }
        
    }
}
