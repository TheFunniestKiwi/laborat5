//
//  ContentView.swift
//  laborat5
//
//  Created by student on 14/11/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: MemoGameViewModel
    var body: some View {
        VStack {
            Text("Memo").font(.largeTitle)
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
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0){
            ForEach(viewModel.cards){card in
                CardView(card, viewModel)
                    .overlay(FlyingNumber(number: 2))
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        let scoreBeforeChoosing = viewModel.score
                        viewModel.chooseWithAnimation(card: card)
                        let scoreChange = viewModel.score - scoreBeforeChoosing
                        lastScoreChange = (viewModel.score, cardId: card.id)
                    }
            }
        }.foregroundColor(viewModel.color)
    }
    
    @State var lastScoreChange = (0, cardId:  "")
    
    private func scoreChange(causedBy card: MemoGameModel<String>.Card)->Int{
        let _ = print(lastScoreChange.0)
        let  (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
}




#Preview {
    ContentView(viewModel: MemoGameViewModel())
}
