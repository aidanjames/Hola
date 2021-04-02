//
//  ParagraphTabView.swift
//  Hola
//
//  Created by Aidan Pendlebury on 01/04/2021.
//

import SwiftUI

struct ParagraphTabView: View {
    
    var paragraphs: Paragraphs
    
    var body: some View {
        NavigationView {
            TabView {
                Text(paragraphs.storyTitle)
                    .font(.largeTitle)
                ForEach(paragraphs.paragraphs) {
                    ParagraphView(paragraph: $0)
                        .padding(.bottom, 50)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .navigationBarTitle(paragraphs.storyTitle, displayMode: .inline)
        }
        .accentColor(Color(hex: "5f939a"))
    }
}

struct ParagraphTabView_Previews: PreviewProvider {
    static var previews: some View {
        let paragraph1 = Paragraph(en: "My shoes are big.", es: "Mis zapatos son grandes.", id: 1)
        let paragraph2 = Paragraph(en: "I really like dogs.", es: "Me gustan mucho los perros.", id: 2)
        let paragraph3 = Paragraph(en: "My shoes are big.", es: "Mis zapatos son grandes.", id: 3)
        let paragraphs = Paragraphs(paragraphs: [paragraph1, paragraph2, paragraph3], storyId: 1, storyTitle: "Mi historia")
        ParagraphTabView(paragraphs: paragraphs)
    }
}
