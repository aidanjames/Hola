//
//  DayView.swift
//  Hola
//
//  Created by Aidan Pendlebury on 10/05/2021.
//

import SwiftUI

struct DayView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                
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
                    .navigationBarItems(
                        leading: Text("Timeline").font(.largeTitle).bold().padding(.top),
                        trailing:
                            Button(action: {}) {
                                Image("ajp")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(25)
                            }
                    )
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView()
        //            .previewLayout(.sizeThatFits)
    }
}
