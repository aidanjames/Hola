//
//  FlashCardsContainerView.swift
//  Hola
//
//  Created by Aidan Pendlebury on 08/04/2021.
//

import SwiftUI

struct FlashCardsContainerView: View {
    
    @ObservedObject var viewModel = FlashCardsContainerViewModel()   
    @State private var offset = CGSize.zero
    @State private var currentIndex = 0
    @State private var showingSpanish = true
    
    var body: some View {
        
        NavigationView {
            VStack {
                Button(showingSpanish ? "Español" : "English") { showingSpanish.toggle() }.padding(.top)
                ZStack {
                    VStack {
                        Text("No \(viewModel.cards.isEmpty ? "flash cards, sorry." : "more cards today :(")")
                        if !viewModel.cards.isEmpty {
                            Button("Reload") {
                                viewModel.reloadCards()
                            }
                            .padding()
                        }
                    }
                    ForEach(0..<viewModel.sortedCards.count, id: \.self) { index in
                        FlashCardView(flashCard: viewModel.sortedCards[index], viewModel: viewModel, showingSpanish: $showingSpanish)
                            .stacked(at: index, in: viewModel.sortedCards.count)
                    }
                }
                .padding(.horizontal, 50)
                .padding(.vertical, 100)
                .navigationBarTitle("Flash cards")
            }
            .onAppear { viewModel.fetchCards() }
        }
        
    }
    
    func printCards() {
        print("---------------------------------")
        for index in 0..<viewModel.cards.count {
            print("Index: \(index) (\(viewModel.cards[index].nextDue)) : (\(viewModel.cards[index].lastSwiped)) (\(viewModel.cards[index].mostRecentSwipeWasCorrect))  - es: \(viewModel.cards[index].es) - en: \(viewModel.cards[index].en)")
        }
    }
}

struct FlashCardsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        FlashCardsContainerView()
    }
}
