//
//  FlashCardsContainerView.swift
//  Hola
//
//  Created by Aidan Pendlebury on 08/04/2021.
//

import SwiftUI

struct FlashCardsContainerView: View {
    
    var flashCards: [FlashCard]
    
    var body: some View {
        ForEach(flashCards) { card in
            FlashCardView(es: card.es, en: card.en)
        }
    }
}

struct FlashCardsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        FlashCardsContainerView(flashCards: FlashCardsPreviewData.mockData)
    }
}
