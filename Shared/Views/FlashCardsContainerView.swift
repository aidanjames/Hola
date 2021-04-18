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
                Text("No \(flashCards.isEmpty ? "" : "more") cards :(")
                ForEach(0..<flashCards.count, id: \.self) { index in
                    FlashCardView(es: flashCards[index].es, en: flashCards[index].en)
                        .stacked(at: index, in: flashCards.count)
                }
            }
            .padding(.horizontal, 50)
            .padding(.vertical, 100)
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
