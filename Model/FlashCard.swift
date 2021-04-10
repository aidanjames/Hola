//
//  FlashCard.swift
//  Hola (iOS)
//
//  Created by Aidan Pendlebury on 10/04/2021.
//

import Foundation

struct FlashCard {
    var es: String
    var en: String
    var lastCorrect: Date
    var correctCount = 0
    var incorrectCount = 0
}
