//
//  MemoGameModel.swift
//  laborat5
//
//  Created by student on 14/11/2023.
//

import Foundation

struct MemoGameModel<CardContent> where CardContent : Equatable {
    private (set) var cards : Array<Card>
    private (set) var score = 0
    private (set) var lastScoreChange = 0
    
    init(numberPairsOfCard: Int, cardContentFactory: (Int)->CardContent){
        cards =  []
        
        for pairIndex in 0..<max(2,numberPairsOfCard) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex)a"))
            cards.append(Card(content: content, id: "\(pairIndex)b"))
        }
    }
    
    private var indexOfSingleRevealedAndUnmatchedCard: Int? {
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

    
    func index(of card: Card) -> Int {
        return cards.firstIndex(where: {$0.id == card.id})!
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        let chosenIndex = index(of: card)
        

        guard !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched else {
            return
        }
        

        if let otherRevealedCardIndex = indexOfSingleRevealedAndUnmatchedCard 
        {
            if cards[chosenIndex].content == cards[otherRevealedCardIndex].content 
            {
                cards[chosenIndex].isMatched = true
                cards[otherRevealedCardIndex].isMatched = true
                lastScoreChange = 4
            }
            else
            {
                if cards[chosenIndex].hasBeenSeen {
                    lastScoreChange = -1
                }
                if cards[otherRevealedCardIndex].hasBeenSeen {
                    lastScoreChange += -1
                }
            }
            
            cards[chosenIndex].isFaceUp = true
        } else {
            indexOfSingleRevealedAndUnmatchedCard = chosenIndex
            lastScoreChange = 0
        }
        
        score += lastScoreChange
    }

    
    
    
    struct Card: Equatable, Identifiable{
       
        
        var isFaceUp = false
        {
            didSet 
            {
                if oldValue && !isFaceUp 
                {
                    hasBeenSeen = true
                }
            }
        }
        var isMatched = false
        var hasBeenSeen = false
        var content: CardContent
        
        var id: String
    }
}
