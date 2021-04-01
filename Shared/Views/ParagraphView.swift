//
//  ParagraphView.swift
//  Hola
//
//  Created by Aidan Pendlebury on 01/04/2021.
//

import SwiftUI

struct ParagraphView: View {
    
    var paragraph: Paragraph
    @State private var showingEs = true
    
    var body: some View {
        VStack {
            Text(showingEs ? paragraph.es : paragraph.en)
                .padding()
            Button(showingEs ? "View translation" : "Show original") {
                withAnimation {
                    showingEs.toggle()
                }
            }
        }
    }
}

struct ParagraphView_Previews: PreviewProvider {
    static var previews: some View {
        let paragraph = Paragraph(en: "My shoes are big.", es: "Mis zapatos son grandes.", id: 1)
        ParagraphView(paragraph: paragraph)
    }
}
