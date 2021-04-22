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
        let wrongCards = cards.filter { !$0.mostRecentSwipeWasCorrect }
        let wrongCardsSorted = wrongCards.sorted(by: { $0.lastSwiped > $1.lastSwiped })
        let correctCards = cards.filter { $0.mostRecentSwipeWasCorrect }
        let correctCardsSorted = correctCards.sorted(by: { $0.lastSwiped > $1.lastSwiped })
        return correctCardsSorted + wrongCardsSorted
//        return cards.sorted(by: { $0.lastCorrect > $1.lastCorrect })
    }
    
    init() { fetchCards() }
    
    
    // Incorrect
    func cardSwipedLeft(_ id: String) {
        if let index = cards.firstIndex(where: { $0.id == id} ) {
            cards[index].lastSwiped = Date()
            // Find the index of cards that were swiped today and put it behind that one
            let element = cards.remove(at: index)
            cards.insert(element, at: 0)
            
            saveCards()
        }
    }
    
    
    // Correct
    func cardSwipedRight(_ id: String) {
        if let index = cards.firstIndex(where: { $0.id == id} ) {
            let now = Date()
            cards[index].lastCorrect = now
            cards[index].lastSwiped = now
            
            let element = cards.remove(at: index)
            cards.insert(element, at: 0)
            
            saveCards()
        }
    }
    
    
    func deleteCard(_ id: String) {
        if let index = cards.firstIndex(where: { $0.id == id} ) {
            cards.remove(at: index)
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
