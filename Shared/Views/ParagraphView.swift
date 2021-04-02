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
                .font(.title3)
                .fontWeight(.light)
                .padding()
                .lineSpacing(10.0)
//                .multilineTextAlignment(.center) 
                .frame(maxWidth: .infinity, minHeight: 450, maxHeight: .infinity)
            Button(showingEs ? "View translation" : "Show original") {
                withAnimation {
                    showingEs.toggle()
                }
            }
        }
        .padding(.bottom, 30)
//        .background(Color.secondary.opacity(0.1))
        .background(Color(hex: "eac8af").opacity(0.5))
        .cornerRadius(16)
        .padding()
    }
}

struct ParagraphView_Previews: PreviewProvider {
    static var previews: some View {
        let paragraph = Paragraph(
            en: "Previsa had great quality: prudence. Neither in that lake nor in the nearby streams there was a more serious trout, sensible and responsible that she. From good, she feeder, she thought that to avoid the dangers it was fundamental to live always alert, attentive to what was happening around her.",
            es: "Previsora tenía una gran cualidad: la prudencia. Ni en ese lago ni en los arroyos cercanos existía una trucha más seria, sensata y responsable que ella. Desde bien pequeñita Previsora pensaba que para evitar los peligros era fundamental vivir siempre alerta, atenta a lo que sucedía a su alrededor. Era tan formal y precavida que el famoso refrán “Más vale prevenir que lamentar” parecía hecho a su medida.",
            id: 1)
        ParagraphView(paragraph: paragraph)
    }
}
