//
//  WrapperTabView.swift
//  Hola
//
//  Created by Aidan Pendlebury on 01/04/2021.
//

import SwiftUI

struct WrapperTabView: View {
    var body: some View {
        TabView {
            
            StoriesListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                }
            
            ContentView()
                .tabItem {
                    Image(systemName: "arrow.left.arrow.right")
                }
            
            FlashCardsContainerView(flashCards: FlashCardsPreviewData.mockData)
                .tabItem {
                    Image(systemName: "bolt.fill")
                }
        }
    }
}

struct WrapperTabView_Previews: PreviewProvider {
    static var previews: some View {
        WrapperTabView()
    }
}
