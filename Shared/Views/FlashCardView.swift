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
    @State private var scale: CGFloat = 1.0
    
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
        .background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray, lineWidth: 1))
        .background(Color(hex: "eac8af").opacity(0.5))
        .background(Color.white)
        .cornerRadius(16)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 2, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .scaleEffect(scale)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                }
                .onEnded { _ in
                    if abs(self.offset.width) > 100 {
                        // TODO: remove the card
                    } else {
                        withAnimation { self.offset = .zero }
                        scale = 1
                    }
                }
        )
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0)
                .onEnded { _ in
                    if scale == 1 {
                        withAnimation { scale = 0.95 }
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
