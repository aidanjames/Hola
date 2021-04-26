//
//  FlashCardsContainerViewModel.swift
//  Hola (iOS)
//
//  Created by Aidan Pendlebury on 18/04/2021.
//

import SwiftUI

class FlashCardsContainerViewModel: ObservableObject {
    @Published var cards: [FlashCard] = []
    var endCardId: String = ""
    
    var sortedCards: [FlashCard] {
        return cards.filter { $0.nextDue < Date() }.sorted(by: { $0.nextDue > $1.nextDue } )
    }
    
    init() { fetchCards() }
    
    
    // Incorrect
    func cardSwipedLeft(_ id: String) {
        if let index = cards.firstIndex(where: { $0.id == id} ) {
            let now = Date()
            cards[index].lastSwiped = now
            cards[index].nextDue = now.add(seconds: sortedCards.count == 1 ? 0 : 1)
            
            saveCards()
        }
    }
    
    
    // Correct
    func cardSwipedRight(_ id: String) {
        if let index = cards.firstIndex(where: { $0.id == id} ) {
            let now = Date()
            cards[index].lastCorrect = now
            cards[index].lastSwiped = now
            cards[index].nextDue = now.tomorrow()
            
            saveCards()
        }
    }
    
    
    func deleteCard(_ id: String) {
        if let index = cards.firstIndex(where: { $0.id == id} ) {
            cards.remove(at: index)
        }
        saveCards()
    }
    
    
    func reloadCards() {
        for i in 0..<cards.count {
            cards[i].nextDue = cards[i].nextDue.addingTimeInterval(-86400)
        }
        saveCards()
    }
    
    
    func fetchCards() {
        guard let savedCards: [FlashCard] = FileManager.default.fetchData(from: "flashCards") else { return }
        cards = savedCards

    }
    
    
    private func saveCards() {
        FileManager.default.writeData(cards, to: "flashCards")
    }
    
}
