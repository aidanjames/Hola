//
//  Story.swift
//  Hola (iOS)
//
//  Created by Aidan Pendlebury on 08/01/2021.
//

import Foundation


// TODO Refactor this file into separate files

struct TranslationResponse: Codable {
    var response: Translation
    
    struct Translation: Codable {
        var es: String
        var en: String
    }
}

struct AllStoriesResponse: Codable {
    var response: Stories
    
    struct Stories: Codable {
        var stories: [Story]
    }
}

struct Story: Codable, Identifiable {
    var id: Int
    var title: String
}

struct StoryResponse: Codable {
    var response: Paragraphs
}

struct Paragraphs: Codable {
    var paragraphs: [Paragraph]
    var storyId: Int
    var storyTitle: String
}

// Now conform to Identifiable
extension Paragraphs: Identifiable {
    var id: Int { return storyId }
}

struct Paragraph: Codable, Identifiable {
    var en: String
    var es: String
    var id: Int
}








/*
 
 {
     "response": {
         "stories": [
             {
                 "id": 1,
                 "title": "Un poco tarde (A little late)"
             },
             {
                 "id": 3,
                 "title": "Las tres truchas (The three Trout)"
             }
         ]
     }
 }

 {
     "response": {
         "paragraphs": [
             {
                 "en": "One day, I will be very strong.",
                 "es": "Un día, seré muy fuerte.",
                 "id": 1
             },
             {
                 "en": "Yes sir.",
                 "es": "Sí señor.",
                 "id": 2
             }
         ],
         "story_id": 1,
         "story_title": "Un poco tarde (A little late)"
     }
 }
 
 */
