//
//  FlashCardsContainerView.swift
//  Hola
//
//  Created by Aidan Pendlebury on 08/04/2021.
//

import SwiftUI

struct FlashCardsContainerView: View {
    
    @State private var flashCards: [FlashCard] = []
    @State private var offset = CGSize.zero
    
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
            .onAppear {
                let savedCards: [FlashCard] = FileManager.default.fetchData(from: "flashCards") ?? []
                flashCards = savedCards.sorted(by: { $0.lastCorrect > $1.lastCorrect })
            }
        }

    }
}

struct FlashCardsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        FlashCardsContainerView()
    }
}
