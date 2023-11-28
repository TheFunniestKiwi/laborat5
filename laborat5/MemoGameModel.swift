//
//  MemoGameModel.swift
//  laborat5
//
//  Created by student on 14/11/2023.
//

import Foundation

struct MemoGameModel<CardContent> where CardContent : Equatable {
    private (set) var cards : Array<Card>
    
    init(numberPairsOfCard: Int, cardContentFactory: (Int)->CardContent){
        cards =  []
        
        for pairIndex in 0..<max(2,numberPairsOfCard) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex)a"))
            cards.append(Card(content: content, id: "\(pairIndex)b"))
        }
    }
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
            get {
                let faceUpCardIndices = cards.indices.filter { cards[$0].isFaceUp && !cards[$0].isMatched}
                return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            }
            set {
                for index in cards.indices {
                    if(!cards[index].isMatched){
                        cards[index].isFaceUp = (index == newValue)
                    }
                }
            }
        }
    
    private mutating func executeDelayedAction() {
        self.cards.indices.forEach { index in
            if !self.cards[index].isMatched {
                self.cards[index].isFaceUp = false
            }
        }
    }
    
//    mutating func choose(_ card: Card){
//        let chosenIndex = index(of: card)
//        cards[chosenIndex].isFaceUp.toggle()
//    }
    
    func index(of card: Card) -> Int {
        return cards.firstIndex(where: {$0.id == card.id})!
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        let chosenIndex = index(of: card)
        
        // Check if the chosen card is face up or matched
        guard !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched else {
            return
        }
        

        if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
            // Check if the symbols match
            if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
                print("Matched")
            }

            // Either way, the chosen card is now face up
            print("Still face up")
            cards[chosenIndex].isFaceUp = true
    
            indexOfOneAndOnlyFaceUpCard = nil
            
            
        } else {
            print("We else")
            // No card or more than one card is face up, so flip them all face down
            print("")
            for index in cards.indices {
                if !cards[index].isMatched {
                    cards[index].isFaceUp = false
                }
            }
            indexOfOneAndOnlyFaceUpCard = chosenIndex
        }
    }

    
    
    
    struct Card: Equatable, Identifiable{
       
        
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        
        var id: String
    }
}
