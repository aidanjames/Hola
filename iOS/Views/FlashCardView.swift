//
//  FlashCardView.swift
//  Hola
//
//  Created by Aidan Pendlebury on 09/04/2021.
//

import SwiftUI

struct FlashCardView: View {
    
    var flashCard: FlashCard
    
    @ObservedObject var viewModel: FlashCardsContainerViewModel
    @State private var showingFront = true
    @State private var offset = CGSize.zero
    @State private var scale: CGFloat = 1.0
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Circle()
                .frame(width: 10, height: 10)
                .padding()
                .foregroundColor(flashCard.mostRecentSwipeWasCorrect ? .green : .red)
            if showingFront {
                Text(flashCard.es)
                    .font(.largeTitle)
                    .padding(.bottom, 100)
            } else {
                Text(flashCard.en)
                    .font(.largeTitle)
                    .padding(.bottom, 100)
            }
            Button(action: { showingFront.toggle() }) {
                Text(showingFront ? "Translate" : "Show original")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(16)
            }
            .padding()
            Button(action: { viewModel.deleteCard(flashCard.id) } ) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .padding(.top, 50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(colorScheme == .light ? Color.white : Color.black)
        .background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray, lineWidth: 1))
        .cornerRadius(16)
        .shadow(color: Color.gray.opacity(0.5), radius: 5)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 2, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .scaleEffect(scale)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { gesture in
                    if scale == 1 {
                        withAnimation { scale = 0.95 }
                    }
                    self.offset = gesture.translation
                }
                .onEnded { _ in
                    if offset.width > 100 {
                        viewModel.cardSwipedRight(flashCard.id)
                        scale = 1
                        offset = CGSize.zero
                    } else if offset.width < -100 {
                        viewModel.cardSwipedLeft(flashCard.id)
                        scale = 1
                        offset = CGSize.zero
                    } else {
                        withAnimation {
                            self.offset = .zero
                            scale = 1
                        }
                    }
                }
        )
    }
}

struct FlashCardView_Previews: PreviewProvider {
    static var previews: some View {
        FlashCardView(flashCard: FlashCard.mockData[0], viewModel: FlashCardsContainerViewModel())
    }
}
