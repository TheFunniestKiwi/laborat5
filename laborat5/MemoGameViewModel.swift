import SwiftUI


class MemoGameViewModel: ObservableObject {
    private static let emojis = ["🐻"]
    private static let emojis2 = ["💣"]
    private static let emojis3 = ["😂"]
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
            pairsByTheme = 50
        case 3:
            arrayByTheme = emojis3
            pairsByTheme = 100
        default:
            arrayByTheme = emojis
            pairsByTheme = 200
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
