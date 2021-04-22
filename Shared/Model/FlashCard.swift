//
//  FlashCard.swift
//  Hola (iOS)
//
//  Created by Aidan Pendlebury on 10/04/2021.
//

import Foundation

struct FlashCard: Identifiable, Codable {
    var id = UUID().uuidString
    var es: String
    var en: String
    var lastCorrect: Date = Date()
    var lastSwiped: Date = Date()
    
    var mostRecentSwipeWasCorrect: Bool { lastCorrect == lastSwiped }
    
    static var mockData: [FlashCard] {
        let cards = [
            FlashCard(es: "Zapato", en: "Shoe", lastCorrect: Date()),
            FlashCard(es: "Verde", en: "Green", lastCorrect: Date()),
            FlashCard(es: "Rojo", en: "Red", lastCorrect: Date())
        ]
        return cards
    }
}

