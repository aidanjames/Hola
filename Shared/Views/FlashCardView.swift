//
//  FlashCardView.swift
//  Hola
//
//  Created by Aidan Pendlebury on 09/04/2021.
//

import SwiftUI

struct FlashCardView: View {
    
    var es: String
    var en: String
    
    @State private var showingFront = true
    @State private var offset = CGSize.zero
    
    var body: some View {
        VStack {
            if showingFront {
                Text(es)
            } else {
                Text(en)
            }
            Button(showingFront ? "Show translation" : "Show original") {
                showingFront.toggle()
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "eac8af").opacity(0.5))
        .background(Color.white)
        .cornerRadius(16)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 3, y: 0)
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
                        withAnimation {
                            self.offset = .zero
                        }
                    }
                }
        )
    }
}

struct FlashCardView_Previews: PreviewProvider {
    static var previews: some View {
        FlashCardView(es: "Zapatos", en: "Shoes")
    }
}
