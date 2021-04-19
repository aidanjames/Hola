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
    
    var body: some View {
        
        NavigationView {
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
        
    }
}

struct FlashCardsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        FlashCardsContainerView()
    }
}
