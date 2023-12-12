import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: MemoGameViewModel
    var body: some View {
        VStack {
            Text("Minesweeper").font(.largeTitle)
            ScrollView{
                cards
            }
            HStack{
               score
                Spacer()
                shuffle
            }.padding(.bottom, 10)
            
            
            themeSelector
            Spacer()
        }
        .padding()
    }
    
    var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    var shuffle: some View{
        Button("SHUFFLE") {
            viewModel.shuffleWithAnimation()
        }
    }
    
    var themeSelector: some View{
        HStack{
            ButtonView(action: {
                viewModel.changeTheme(to: 1)}, symbol: Image(systemName: "paintbrush.fill") , text: "Theme 1").foregroundStyle(.red)
            Spacer()
            ButtonView(action: {
                viewModel.changeTheme(to: 2)}, symbol: Image(systemName:"paintbrush.fill"), text: "Theme 2").foregroundStyle(.orange)
            Spacer()
            ButtonView(action: {
                viewModel.changeTheme(to: 3)}, symbol: Image(systemName: "paintbrush.fill"), text: "Theme 3").foregroundStyle(.blue)
        }
    }
    var cards : some View {
        Grid{
            ForEach(viewModel.cards, id:\.self){cardRow in
                GridRow {
                    ForEach(cardRow) {card in
                        CardView(card, viewModel)
                            .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                            .aspectRatio(2/3, contentMode: .fit)
                            .padding(1)
                            .onChange(of: card.isFaceUp,
                                      {
                                lastScoreChange = (amount: viewModel.lastScoreChange, cardId: card.id)
                            }
                            )
                    }.foregroundColor(viewModel.color)
                }
            }
        }
    }
    
    @State var lastScoreChange = (amount: 0, cardId:  "")
    
    private func scoreChange(causedBy card: MemoGameModel<String>.Card)->Int{
        let  (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
}




#Preview {
    ContentView(viewModel: MemoGameViewModel())
}
