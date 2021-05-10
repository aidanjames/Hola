//
//  DayView.swift
//  Hola
//
//  Created by Aidan Pendlebury on 10/05/2021.
//

import SwiftUI

struct DayView: View {
      
    var body: some View {
        ScrollView {
            HStack {
                VStack {
                    ForEach(0..<24) { hour in
                        VStack {
                            Text("\(hour):00 \(hour < 12 ? "am" : "pm")")
                            Text("|")
                            Text("|")
                        }
                        .padding(.leading)
                    }
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 500)
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView()
            .previewLayout(.sizeThatFits)
    }
}
