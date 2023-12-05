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
                   .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                   .animation(.spin(duration: 2), value: card.isMatched)
            )
            .opacity(card.isFaceUp ? 1 : 0)
            .padding(5)
            .transformIntoCard(isFaceUp: card.isFaceUp, color: viewModel.color)
        .onTapGesture {
                viewModel.chooseWithAnimation(card: card)
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
