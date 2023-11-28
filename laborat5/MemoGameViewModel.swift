//
//  MemoGameViewModel.swift
//  laborat5
//
//  Created by student on 14/11/2023.
//

import SwiftUI


class MemoGameViewModel: ObservableObject {
    private static let emojis = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻"]
    private static let emojis2 = ["🕷️","🕸️","🦂","🐍","🦎","🪼","🐜"]
    private static let emojis3 = ["😂","🤣","🥲","😍","😭","😡","🥺"]
    public static var theme: Int = 1
    var color: Color {
           switch MemoGameViewModel.theme {
           case 1:
               return .red
           case 2:
               return .orange
           case 3:
               return .blue
           default:
               return .clear
           }
       }
    
    
    static func createMemoGame(theme: Int)  -> MemoGameModel<String> {
        
        var arrayByTheme: [String]
        var pairsByTheme: Int
        
        switch theme {
        case 2:
            arrayByTheme = emojis2
            pairsByTheme = 7
        case 3:
            arrayByTheme = emojis3
            pairsByTheme = 6
        default:
            arrayByTheme = emojis
            pairsByTheme = 8
        }
        
        return MemoGameModel<String>(
            numberPairsOfCard: pairsByTheme){index in
                    if arrayByTheme.indices.contains(index){
                        return arrayByTheme[index]
                    }else{
                        return "❓"
                    }
            }
    }
    
    @Published private var  model = MemoGameViewModel.createMemoGame(theme: MemoGameViewModel.theme)
    
    
    
    
    var cards: Array<MemoGameModel<String>.Card>{
        return model.cards
    }
    

    func shuffleWithAnimation() {
        withAnimation {
            model.shuffle()
        }
    }
    
    func chooseWithAnimation(card: MemoGameModel<String>.Card) {
        withAnimation {
            model.choose(card)
        }
    }
    



    
    func changeTheme(to theme: Int) {
        MemoGameViewModel.theme = theme
        model = MemoGameViewModel.createMemoGame(theme: theme)
        shuffleWithAnimation()
    }

}
