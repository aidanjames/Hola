//
//  FlashCardsContainerViewModel.swift
//  Hola (iOS)
//
//  Created by Aidan Pendlebury on 18/04/2021.
//

import SwiftUI

class FlashCardsContainerViewModel: ObservableObject {
    @Published var cards: [FlashCard] = []
    
    var sortedCards: [FlashCard] {
        cards.sorted(by: { $0.lastCorrect > $1.lastCorrect })
    }
    
    init() {
        guard let savedCards: [FlashCard] = FileManager.default.fetchData(from: "flashCards") else { return }
        cards = savedCards
    }
    
    func cardSwipedLeft(_ id: String) {
        
    }
    
    func cardSwipedRight(_ id: String) {
        if let index = cards.firstIndex(where: { $0.id == id} ) {
            cards[index].lastCorrect = Date()
            
            let element = cards.remove(at: index)
            cards.insert(element, at: 0)
            
            saveCards()
        }
    }
    
    private func saveCards() {
        FileManager.default.writeData(cards, to: "flashCards")
    }
}
