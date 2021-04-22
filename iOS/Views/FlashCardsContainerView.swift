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
    
    var body: some View {
        
        NavigationView {
            VStack {
                Button("Print stuff") { printCards() }.padding()
                ZStack {
                    Text("No \(viewModel.sortedCards.isEmpty ? "" : "more") cards :(")
                    ForEach(0..<viewModel.sortedCards.count, id: \.self) { index in
                        FlashCardView(flashCard: viewModel.sortedCards[index], viewModel: viewModel)
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
            print("Index: \(index) (\(viewModel.sortedCards[index].lastCorrect)) : (\(viewModel.sortedCards[index].lastSwiped)) (\(viewModel.sortedCards[index].mostRecentSwipeWasCorrect))  - es: \(viewModel.sortedCards[index].es) - en: \(viewModel.sortedCards[index].en)")
        }
    }
}

struct FlashCardsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        FlashCardsContainerView()
    }
}
