//
//  Story.swift
//  Hola (iOS)
//
//  Created by Aidan Pendlebury on 08/01/2021.
//

import Foundation

struct Story: Codable {
    var title: String
    var story: [Paragraph]
}

struct Paragraph: Codable {
    var translation: Translation
}

struct Response: Codable {
    var response: Translation
}

struct Translation: Codable {
    var es: String
    var en: String
}

/*

 { story_title: [
        {
            "es": "Hola",
            "en": "Hello"
        },
        {
            "es": "Zapatos",
            "en": "Shoes"
        }
    ]
 }
 
 
 */
