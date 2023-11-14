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
            Button("SHUFFLE") {
                viewModel.shuffleWithAnimation()
            }

            themeSelector
            Spacer()
        }
        .padding()
    }
    
    var themeSelector: some View{
        HStack{
            ButtonView(action: {
                viewModel.changeTheme(to: 1)}, symbol: Image(systemName: "paintbrush.fill") , text: "Motyw 1").foregroundStyle(.red)
            Spacer()
            ButtonView(action: {
                viewModel.changeTheme(to: 2)}, symbol: Image(systemName:"paintbrush.fill"), text: "Motyw 2").foregroundStyle(.orange)
            Spacer()
            ButtonView(action: {
                viewModel.changeTheme(to: 3)}, symbol: Image(systemName: "paintbrush.fill"), text: "Motyw 3").foregroundStyle(.blue)
        }
    }
    var cards : some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0){
            ForEach(viewModel.cards){card in
                CardView(card, viewModel)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.chooseWithAnimation(card: card)
                    }
            }
        }.foregroundColor(viewModel.color)
    }
}




#Preview {
    ContentView(viewModel: MemoGameViewModel())
}
