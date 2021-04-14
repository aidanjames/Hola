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
                            .rotationEffect(.degrees(Double(offset.width / 5)))
                            .offset(x: offset.width * 5, y: 0)
                            .opacity(2 - Double(abs(offset.width / 50)))
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        self.offset = gesture.translation
                                    }

                                    .onEnded { _ in
                                        if abs(self.offset.width) > 100 {
                                            // remove the card
                                        } else {
                                            self.offset = .zero
                                        }
                                    }
                            )
                        
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
