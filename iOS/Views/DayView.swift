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
                    VStack {
                        HStack {
                            Text("March")
                                .padding(.leading)
                                .padding(.bottom, 5)
                            Spacer()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(1..<32) { day in
                                    Text("\(day)")
                                        .padding(.horizontal)
                                }
                            }
                        }
                        .padding(.bottom, 15)
                    }
                ScrollView(showsIndicators: false) {
                    HStack {
                        VStack {
                            ForEach(0..<24) { hour in
                                HStack(alignment: .top) {
                                    VStack {
                                        Text("\(hour):00 \(hour < 12 ? "am" : "pm")")
                                        Rectangle()
                                            .frame(width: 2, height: 50)
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.horizontal)
                                    VStack(alignment: .leading) {
                                        Text("English").bold()
                                        HStack {
                                            Image(systemName: "mappin.and.ellipse")
                                            Text("Room A12")
                                        }.font(.caption)
                                        HStack {
                                            Image(systemName: "person.fill")
                                            Text("Room A12")
                                        }.font(.caption)
                                    }
                                    
                                }
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
