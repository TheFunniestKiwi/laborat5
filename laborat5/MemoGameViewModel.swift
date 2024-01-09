import SwiftUI


class MemoGameViewModel: ObservableObject {
    private static let bombSymbol_1 = "🐻"
    private static let bombSymbol_2 = "💣"
    private static let bombSymbol_3 = "😂"
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
        
        var bombSymbol: String
        var boardSizeByTheme: Int
        
        switch theme {
        case 2:
            bombSymbol = bombSymbol_2
            boardSizeByTheme = 6
        case 3:
            bombSymbol = bombSymbol_3
            boardSizeByTheme = 8
        default:
            bombSymbol = bombSymbol_1
            boardSizeByTheme = 12
        }
        
        return MemoGameModel<String>(boardSize: boardSizeByTheme, bombChance: Double(boardSizeByTheme) * 0.04, bombSymbol: bombSymbol)
    }
    
    @Published private var  model = MemoGameViewModel.createMemoGame(theme: MemoGameViewModel.theme)
    
    
    
    
    var cards: Array<Array<MemoGameModel<String>.Card>>{
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    var lastScoreChange: Int {
        return model.lastScoreChange
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
