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
        let savedCards: [FlashCard] = FileManager.default.fetchData(from: "flashCards") ?? []
        cards = savedCards
    }
    
    func cardSwipedLeft(_ id: String) {
        
    }
    
    func cardSwipedRight(_ id: String) {
        if let index = cards.firstIndex(where: { $0.id == id} ) {
            cards[index].lastCorrect = Date()
            saveCards()
        }
    }
    
    private func saveCards() {
        FileManager.default.writeData(cards, to: "flashCards")
    }
}
