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
    }
}

struct FlashCardView_Previews: PreviewProvider {
    static var previews: some View {
        FlashCardView(es: "Zapatos", en: "Shoes")
    }
}
