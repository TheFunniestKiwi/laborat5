import Foundation

struct MemoGameModel<CardContent> where CardContent : Equatable {
    private (set) var cards : Array<Array<Card>>
    private (set) var score = 0
    private (set) var lastScoreChange = 0
    
    init(boardSize: Int, cardContentFactory: (Int)->CardContent){
        cards =  []
        
        for row in 0...boardSize {
            cards.append(Array<Card>())
            for colIdx in 0...boardSize
            {
                let content = cardContentFactory(colIdx)
                cards[row].append(Card(content: content, id: "\(UUID())"))
            }
        }
    }
    
    func index(of card: Card) -> (Int, Int) {
        var cardRowIdx = 0
        var cardColIdx = 0
        for rowIdx in 0..<cards.count {
            print(rowIdx)
            if (cards[rowIdx].contains(where: {$0.id == card.id}))
            {
                print(String(rowIdx) + "Inside")
                cardRowIdx = rowIdx
                cardColIdx = cards[cardRowIdx].firstIndex(where: {$0.id == card.id})!
                return (cardRowIdx, cardColIdx)
            }
        }
        return (0, 0)
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func reveal(row: Int, col: Int)
    {
        //print("Row: " + String(row) + " Col: " + String(col))
        cards[row][col].isFaceUp = true
        if (row-1 >= 0 && cards[row-1][col].isFaceUp == false)
        {
            reveal(row: row-1, col: col)
        }
        if (row+1 < cards.count && cards[row+1][col].isFaceUp == false)
        {
            reveal(row: row+1, col: col)
        }
        if (col-1 >= 0 && cards[row][col-1].isFaceUp == false)
        {
            reveal(row: row, col: col-1)
        }
        if (col+1 < cards.count && cards[row][col+1].isFaceUp == false)
        {
            reveal(row: row, col: col+1)
        }
    }
    
    mutating func choose(_ card: Card) {

        let chosenIndex = index(of: card)

        reveal(row: chosenIndex.0, col: chosenIndex.1)

        score += lastScoreChange
    }

    struct Card: Equatable, Identifiable, Hashable{
       
        func hash(into myhasher: inout Hasher)
        {
            myhasher.combine(id)
        }
        
        var isFlagged = false
        var isBomb = false
        var isFaceUp = false
        var content: CardContent
        var id: String
    }
}


enum NotFoundCardError : Error{
    case NotFound
}
