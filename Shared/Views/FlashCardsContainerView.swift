//
//  FlashCardsContainerView.swift
//  Hola
//
//  Created by Aidan Pendlebury on 08/04/2021.
//

import SwiftUI

struct FlashCardsContainerView: View {
    
    var flashCards: [FlashCard] = []
    
    var body: some View {
        
        NavigationView {
            ZStack {
                if flashCards.isEmpty {
                    Text("No flash cards yet...")
                } else {
                    ForEach(flashCards) { card in
                        FlashCardView(es: card.es, en: card.en)
                    }
                }
            }
            .navigationBarTitle("Flash cards")
        }

    }
}

struct FlashCardsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        FlashCardsContainerView(flashCards: FlashCardsPreviewData.mockData)
    }
}
